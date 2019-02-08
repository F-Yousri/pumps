module DecisionMakerService
    class << self


        def make params
            techParams = self.extractTechParams params
            weightParams = self.extractWeightParams params
            additionalCriteria = self.extractAdditionalCriteria params
            params = self.mixtureCalc params
            params = self.check techParams
            pumps = self.match( techParams, weightParams, additionalCriteria )            
            pumpsSeparation = self.findSeparation( pumps[:pumps], pumps[:solutions] ) 
            sortedPumps = self.sortByCi pumpsSeparation
        end

        def extractTechParams params
            techParams = params.slice(:WL, :MD, :WD, :CSG_ND, :DS, :GQ, :J, :T_bh, :meo_m, :API, :AP, :CP, :ArP, :EP, :SP, :PP, :GLR, :APM, :SE, :AST, :PF, :PR )
        end

        def extractWeightParams params
            weightParams = params.slice( :W_WL, :W_MD, :W_WD, :W_CSG_ND, :W_DS, :W_GQ, :W_J, :W_T_bh, :W_meo_m, :W_API, :W_AP, :W_CP, :W_ArP, :W_EP, :W_SP, :W_PP, :W_GLR, :W_APM, :W_SE, :W_AST, :W_PF, :W_PR, :W_ES )
        end
        
        def extractAdditionalCriteria params
            additionalCriteria = params.slice(:PF_esp, :PF_espcp, :PF_pcp, :PR_esp, :PR_espcp, :PR_pcp, :PF_rrp, :SE_espcp, :SE_pcp, :SE_esp, :PR_rrp, :SE_rrp)
        end

        #calculate some props and add it to input params
        def mixtureCalc params
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
                params['MD'] = "Intermediate"
            when 6000..10000
                params['MD'] = "Deep"
            else
                params['MD'] = "Extremely Deep"
            end

            case params['WD'].to_f
            when 0..19
                params['WD'] = "Vertical"
            when 20..49
                params['WD'] = "Deviated"
            when 50..79
                params['WD'] = "Extremely Deviated"
            else
                params['WD'] = "Horizontal"
            end


            case params['DS'].to_f
            when 0..6
                params['DS'] = "Normal"
            else
                params['DS'] = "Severe"
            end

            case params['GQ']
            when 0..199
                params['GQ'] = "Low Production"
            when 200..1499
                params['GQ'] = "Intermediate Production"
            when 1500..4500
                params['GQ'] = "High Production"
            else
                params['GQ'] = "Extremely high production"
            end

            case params['J'].to_f
            when 0..0.5
                params['J'] = "Low productivity reservoir"
            else
                params['J'] = "High productivity reservoir"
            end

            case params['T_bh'].to_f
            when 0..149
                params['T_bh'] = "Normal"
            when 150..249
                params['T_bh'] = "Intermediate"
            when 250..399
                params['T_bh'] = "Hot"
            else
                params['T_bh'] = "Extremely Hot"
            end

            case params['meo_m'].to_f
            when 0..199
                params['meo_m'] = "Thin fluid"
            when 200..499
                params['meo_m'] = "Viscous fluid"
            else
                params['meo_m'] = "High viscous fluid"
            end

            case params['API'].to_f
            when 0..14
                params['API'] = "Heavy Oil"
            when 15..34
                params['API'] = "Intermediate Oil"
            else
                params['API'] = "Light Oil"
            end

            case params['GLR'].to_f
            when 0..499
                params['GLR'] = "Low gas production"
            when 500..1999
                params['GLR'] = "Intermediate gas production"
            else
                params['GLR'] = "High gas production"
            end
            params
        end
        #match the input with the corresponding pumpProperty rating and increments the pump rating
        def match(techParams, weightParams, additionalCriteria)
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
                    propArray = pumpProperty.select { |prop| (prop.property.choice_type == "list_box") ? (prop.choice_id == val.to_f) : (prop.choice.name == val) }
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
            xi_es = Math.sqrt(additionalCriteria['SE_espcp'].to_f ** 2 + additionalCriteria['SE_pcp'].to_f ** 2 + additionalCriteria['SE_esp'].to_f ** 2 + additionalCriteria['SE_rrp'].to_f ** 2)
            bestSolutions['SE'] = additionalCriteria.values.map(&:to_i).max * weightParams["W_ES"].to_f / xi_es
            worstSolutions['SE'] = additionalCriteria.values.map(&:to_i).min * weightParams["W_ES"].to_f / xi_es
            
            xi_pr = Math.sqrt(additionalCriteria['PR_espcp'].to_f ** 2 + additionalCriteria['PR_pcp'].to_f ** 2 + additionalCriteria['PR_esp'].to_f ** 2 + additionalCriteria['PR_rrp'].to_f ** 2)
            bestSolutions['PR'] = additionalCriteria.values.map(&:to_i).max * weightParams["W_PR"].to_f / xi_pr
            worstSolutions['PR'] = additionalCriteria.values.map(&:to_i).min * weightParams["W_PR"].to_f / xi_pr
            
            xi_pf = Math.sqrt(additionalCriteria['PF_espcp'].to_f ** 2 + additionalCriteria['PF_pcp'].to_f ** 2 + additionalCriteria['PF_esp'].to_f ** 2 + additionalCriteria['PF_rrp'].to_f ** 2)
            bestSolutions['PF'] = additionalCriteria.values.map(&:to_i).max * weightParams["W_PF"].to_f / xi_pf
            worstSolutions['PF'] = additionalCriteria.values.map(&:to_i).min * weightParams["W_PF"].to_f / xi_pf
            additionalCriteria.each do |k, val|
                if k.include? "SE"
                    if k.include? 'espcp'
                        pumpsHash['ESPCP']['ES'] = val.to_f * weightParams["W_ES"].to_f / xi_es
                    elsif k.include? 'esp'
                        pumpsHash['ESP']['ES'] = val.to_f * weightParams["W_ES"].to_f / xi_es
                    elsif k.include? 'pcp'
                        pumpsHash['PCP']['ES'] = val.to_f * weightParams["W_ES"].to_f / xi_es
                    elsif k.include? 'rrp'
                        pumpsHash['RRP']['ES'] = val.to_f * weightParams["W_ES"].to_f / xi_es
                    end
                elsif k.include? "PF"
                    if k.include? 'espcp'
                        pumpsHash['ESPCP']['PF'] = val.to_f * weightParams["W_PF"].to_f / xi_pf
                    elsif k.include? 'esp'
                        pumpsHash['ESP']['PF'] = val.to_f * weightParams["W_PF"].to_f / xi_pf
                    elsif k.include? 'pcp'
                        pumpsHash['PCP']['PF'] = val.to_f * weightParams["W_PF"].to_f / xi_pf
                    elsif k.include? 'rrp'
                        pumpsHash['RRP']['PF'] = val.to_f * weightParams["W_PF"].to_f / xi_pf
                    end
                elsif k.include? "PR"
                    if k.include? 'espcp'
                        pumpsHash['ESPCP']['PR'] = val.to_f * weightParams["W_PR"].to_f / xi_pr
                    elsif k.include? 'esp'
                        pumpsHash['ESP']['PR'] = val.to_f * weightParams["W_PR"].to_f / xi_pr
                    elsif k.include? 'pcp'
                        pumpsHash['PCP']['PR'] = val.to_f * weightParams["W_PR"].to_f / xi_pr
                    elsif k.include? 'rrp'
                        pumpsHash['RRP']['PR'] = val.to_f * weightParams["W_PR"].to_f / xi_pr
                    end
                end
            end
            # return techParams
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