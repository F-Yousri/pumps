module DecisionMakerService
    class << self


        def make params
            techParams = self.extractTechParams params
            weightParams = self.extractWeightParams params
            params = self.mixtureCalc techParams
            params = self.check techParams
            pumps = self.match( techParams, weightParams )
            pumpsSeparation = self.findSeparation( pumps[:pumps], pumps[:solutions] ) 
            sortedPumps = self.sortByCi pumpsSeparation
        end

        def extractTechParams params
            techParams = params.slice( :WL, :MD, :WD, :CSG_ND, :DS, :GQ, :J, :T_bh, :meo_m, :API, :AP, :CP, :ArP, :EP, :SP, :PP, :GLR, :APM, :SE, :AST, :PF, :PR, :SE )
            techParams
        end

        def extractWeightParams params
            weightParams = params.slice( :W_WL, :W_MD, :W_WD, :W_CSG_ND, :W_DS, :W_GQ, :W_J, :W_T_bh, :W_meo_m, :W_API, :W_AP, :W_CP, :W_ArP, :W_EP, :W_SP, :W_PP, :W_GLR, :W_APM, :W_SE, :W_AST, :W_PF, :W_PR, :W_SE )
            weightParams
        end
        #calculate some props and add it to input params
        def mixtureCalc params
             #calculate Mixture Viscosity in cp and add it to params object
             if params['EP'] == true
                params['meo_m'] = params['meo_o'].to_f * ( 1 + 2.5 * params['WC'].to_f + 10 * ( params['WC'].to_f ** 2 ) )
            else
                params['meo_m'] = params['WC'].to_f * params['meo_w'].to_f + params['meo_o'].to_f * ( 1 - params['WC'].to_f )
            end

            #calculate Liqued Mixture Specific Gravity and add it to params object
            params['SG_m'] = ( params['SG_o'].to_f *  ( 1 - params['WC'].to_f )) + (params['SG_w'].to_f * params['WC'].to_f ) 
            params
        end
        
        #match input with the corresponding property choice
        #this function can be refractored to do better matching but wasn't due to time constraint
        def check params
            case params['MD'].to_f
            when 0..4499
                params['MD'] = "shallow"
            when 4500..5999
                params['MD'] = "intermediate"
            when 6000..10000
                params['MD'] = "deep"
            else
                params['MD'] = "extremely deep"
            end

            case params['WD'].to_f
            when 0..19
                params['WD'] = "vertical"
            when 20..49
                params['WD'] = "deviated"
            when 50..79
                params['WD'] = "extremely deviated"
            else
                params['WD'] = "horizontal or extended reach"
            end

            case params['CSG_ND']
            when 1..3
                params['CSG_ND'] = 1
            else
                params['CSG_ND'] = 4
            end



            case params['DS'].to_f
            when 0..6
                params['DS'] = "6"
            else
                params['DS'] = "7"
            end

            case params['GQ']
            when 0..199
                params['GQ'] = "200"
            when 200..1499
                params['GQ'] = "1500"
            when 1500..4500
                params['GQ'] = "4500"
            else
                params['GQ'] = "4501"
            end

            case params['J'].to_f
            when 0..0.5
                params['J'] = "0.5"
            else
                params['J'] = "0.51"
            end

            case params['T_bh'].to_f
            when 0..149
                params['T_bh'] = "150"
            when 150..249
                params['T_bh'] = "250"
            when 250..399
                params['T_bh'] = "400"
            else
                params['T_bh'] = "401"
            end

            case params['meo_m'].to_f
            when 0..199
                params['meo_m'] = "200"
            when 200..499
                params['meo_m'] = "500"
            else
                params['meo_m'] = "501"
            end

            case params['API'].to_f
            when 0..14
                params['API'] = "15"
            when 15..34
                params['API'] = "35"
            else
                params['API'] = "36"
            end

            case params['GLR'].to_f
            when 0..499
                params['GLR'] = "500"
            when 500..1999
                params['GLR'] = "2000"
            else
                params['GLR'] = "3000"
            end
            params
        end
        #match the input with the corresponding pumpProperty rating and increments the pump rating
        def match(techParams, weightParams)
            matrix = PumpProperty::all
            pumpsArray = Pump::select(:name).as_json
            #build a hash of { pump.name => { property.name => pumpProperty.rating, .. }, ..}
            pumpsHash = pumpsArray.map { |pump| [ pump['name'], {}] }.to_h

            #define hashes to store properties best solution and worst solotuion {property.name =>value}
            bestSolutions = {}
            worstSolutions = {}

            techParams.each do |k, val|
                #build a hash of {inputValue => [all pump properties associated to that property]}
                techParams[k] = {val=>matrix.select { |pumpProperty| pumpProperty.property.name == k }}
                
                # Iterate through the pump properties to get the ones matching the inputValue
                techParams[k].each do |val, pumpProperty|
                        propArray = pumpProperty.select { |prop| prop.choice.name == val }
                        if propArray
                            # determine value of X_i which is sqrt(sum(each row value ^2))
                            xi = Math.sqrt(propArray.inject(0) {|sum, p| sum + p.rating.to_f ** 2})
                            
                            propArray.each do |prop|
                                solution = prop.rating.to_f * weightParams["W_" + k].to_f / xi
                                #add {property.name => ( pumpProperty.rating * property weight / X_i ) } to pumpsHash
                                pumpsHash[prop.pump.name][k] = solution
                                if ! bestSolutions[k] || bestSolutions[k] < solution
                                    bestSolutions[k] = solution
                                end
                                if ! worstSolutions[k] || worstSolutions[k] > solution
                                    worstSolutions[k] = solution
                                end
                            end
                        end
                end
            end
            pumps ={   :pumps=>pumpsHash, 
                :solutions=>{ 
                    :best=>bestSolutions, :worst=>worstSolutions
                }
            }
        end

        #determine positive and negative separaion for each property in every pump
        def findSeparation(pumps, solutions)
            pumps.each do |pump|
                pump[1]['positiveSep'] = 0
                pump[1]['negativeSep'] = 0
                pump[1].each do |property|
                    if solutions[:best][property[0]]

                        positiveSep = ( solutions[:best][property[0]].to_f - pump[1][property[0]].to_f ) **2
                        pump[1]['positiveSep'] += positiveSep
                    end
                    if solutions[:worst][property[0]]
                        negativeSep = ( solutions[:worst][property[0]].to_f - pump[1][property[0]].to_f ) **2
                        pump[1]['negativeSep'] += negativeSep
                    end
                end
                pump[1]['positiveSep'] = Math.sqrt(pump[1]['positiveSep'])
                pump[1]['negativeSep'] = Math.sqrt(pump[1]['negativeSep'])

            end
            pumps
        end

        def sortByCi pumpsSeparation

            pumpsSeparation.each do |pump|
                #calculate ci where dominator != 0
                if pump[1]['positiveSep'] > 0 || pump[1]['negativeSep'] > 0
                    pump[1]['ci'] = pump[1]['negativeSep'] / ( pump[1]['positiveSep'] +  pump[1]['negativeSep'])
                end
            end
            sortedBySep = pumpsSeparation.sort_by { |pump| pump[1]['ci']}.reverse         
        end
        
    end
end