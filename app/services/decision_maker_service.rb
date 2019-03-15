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
            techParams = params.slice(:StE_rrp, :StE_esp, :StE_espcp, :StE_pcp, :WL, :MD_pump, :WD, :CSG_ND, :DS, :GQ, :J, :T_bh, :meo_m, :API, :AP, :CP, :ArP, :EP, :SP, :PP, :GLR, :APM, :SE, :AST, :PF, :PR )
        end

        def extractWeightParams params
            weightParams = params.slice( :W_WL, :W_MD_pump, :W_WD, :W_CSG_ND, :W_DS, :W_GQ, :W_J, :W_T_bh, :W_meo_m, :W_API, :W_AP, :W_CP, :W_ArP, :W_EP, :W_SP, :W_PP, :W_GLR, :W_APM, :W_SE, :W_AST, :W_PF, :W_PR, :W_ES )
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
            case params['MD_pump'].to_f
            when 0..4499
                params['MD_pump'] = "Shallow"
            when 4500..5999
                params['MD_pump'] = "Intermediate"
            when 6000..10000
                params['MD_pump'] = "Deep"
            else
                params['MD_pump'] = "Extremely Deep"
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

            case params['GQ'].to_f
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
            #get array of StE properties
            steArray = matrix.select{|pumpProperty| (pumpProperty.property.name.include? "StE_")}
            xi_ste = Math.sqrt(steArray.inject(0) {|sum, p| sum + p.rating.to_f ** 2})
            #define hashes to store properties best solution and worst solotuion {property.name =>value}
            bestSolutions = {}
            worstSolutions = {}
            techParams.each do |k, val|
                #build a hash of {inputValue => [all pump properties associated to that property]}
                techParams[k] = {val=>matrix.select { |pumpProperty| pumpProperty.property.name == k }}
                # Iterate through the pump properties to get the ones matching the inputValue
                techParams[k].each do |val, pumpProperty|
                    pumpProperty = if k.include? "StE_" then steArray else pumpProperty end
                    propArray = pumpProperty.select { |prop| (prop.property.choice_type == "list_box") ? (prop.choice_id == val.to_f) : (prop.choice.name == val) }
                    if propArray
                        # determine value of X_i which is sqrt(sum(each row value ^2))
                        xi = Math.sqrt(propArray.inject(0) {|sum, p| sum + p.rating.to_f ** 2})
                        
                        propArray.each do |prop|
                            weightFactor = if prop.property.name.include? "StE" then weightParams["W_SE"]  else weightParams["W_" + k] end
                                xi = if prop.property.name.include? "StE" then xi_ste else xi end
                                k = if prop.property.name.include? "StE" then "StE"  else k end
                            solution = prop.rating.to_f * weightFactor.to_f / (xi * 100)
                            #add {property.name => ( pumpProperty.rating * property weight / X_i ) } to pumpsHash
                            pumpsHash[prop.pump.name][k] = [prop.rating.to_f, solution]
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

            #loop throw efficiency inputs yo map them to 1 to 5 measure
            efficiencyInputs = additionalCriteria.to_unsafe_h
            .select{|name, rating| name.include? "SE"}.sort{|prop1, prop2| prop2[1] <=> prop1[1]}.to_h
            
            ratedEfficiencyInputs = efficiencyInputs.each_with_index.map {|(name, rating), index| [name, (5 - index).to_s] }.to_h   
            # if 2 SEs have the same value then they should have the same rating
            efficiencyInputs.each do|input|
                # a flag so that if one rating is raised then raise all less ratings
                raiseAll = 0
                efficiencyInputs.each do |input2|
                    next unless input[0] != input2[0]
                    if input2[1] === input[1]
                        ratedEfficiencyInputs[input2[0]] = ratedEfficiencyInputs[input[0]]
                        efficiencyInputs[input2[0]] = rand(0..9999999) - efficiencyInputs[input2[0]].to_i 
                        raiseAll = 1
                    elsif raiseAll === 1
                        ratedEfficiencyInputs[input2[0]] = ratedEfficiencyInputs[input2[0]].to_i + 1
                        efficiencyInputs[input2[0]] = rand(0..9999999) - efficiencyInputs[input2[0]].to_i 
                    end
                end
            end
            additionalCriteria.merge!(ratedEfficiencyInputs)
            xi_es = Math.sqrt(efficiencyInputs['SE_espcp'].to_f ** 2 + efficiencyInputs['SE_pcp'].to_f ** 2 + efficiencyInputs['SE_esp'].to_f ** 2 + efficiencyInputs['SE_rrp'].to_f ** 2)
            bestSolutions['SE'] = additionalCriteria.values.map(&:to_i).max * weightParams["W_ES"].to_f / (xi_es * 100)
            worstSolutions['SE'] = additionalCriteria.values.map(&:to_i).min * weightParams["W_ES"].to_f / (xi_es * 100)
            
            xi_pr = Math.sqrt(additionalCriteria['PR_espcp'].to_f ** 2 + additionalCriteria['PR_pcp'].to_f ** 2 + additionalCriteria['PR_esp'].to_f ** 2 + additionalCriteria['PR_rrp'].to_f ** 2)
            bestSolutions['PR'] = additionalCriteria.values.map(&:to_i).max * weightParams["W_PR"].to_f / (xi_pr * 100)
            worstSolutions['PR'] = additionalCriteria.values.map(&:to_i).min * weightParams["W_PR"].to_f / (xi_pr * 100)
            
            xi_pf = Math.sqrt(additionalCriteria['PF_espcp'].to_f ** 2 + additionalCriteria['PF_pcp'].to_f ** 2 + additionalCriteria['PF_esp'].to_f ** 2 + additionalCriteria['PF_rrp'].to_f ** 2)
            bestSolutions['PF'] = additionalCriteria.values.map(&:to_i).max * weightParams["W_PF"].to_f / (xi_pf * 100)
            worstSolutions['PF'] = additionalCriteria.values.map(&:to_i).min * weightParams["W_PF"].to_f / (xi_pf * 100)
            additionalCriteria.each do |k, val|
                if k.include? "SE"
                    weightFactor = weightParams['W_ES'].to_f / 100
                    xi = xi_es
                    solution = val.to_f * weightFactor / xi
                    if k.include? 'espcp'
                        pumpsHash['ESPCP']['SE'] = [val.to_f, solution]
                    elsif k.include? 'esp'
                        pumpsHash['ESP']['SE'] = [val.to_f, solution]
                    elsif k.include? 'pcp'
                        pumpsHash['PCP']['SE'] = [val.to_f, solution]
                    elsif k.include? 'rrp'
                        pumpsHash['RRP']['SE'] = [val.to_f, solution]
                    end
                elsif k.include? "PF"
                    weightFactor = weightParams['W_PF'].to_f / 100
                    xi = xi_pf
                    solution = val.to_f * weightFactor / xi
                    if k.include? 'espcp'
                        pumpsHash['ESPCP']['PF'] = [val.to_f, solution]
                    elsif k.include? 'esp'
                        pumpsHash['ESP']['PF'] = [val.to_f, solution]
                    elsif k.include? 'pcp'
                        pumpsHash['PCP']['PF'] = [val.to_f, solution]
                    elsif k.include? 'rrp'
                        pumpsHash['RRP']['PF'] = [val.to_f, solution]
                    end
                elsif k.include? "PR"
                    weightFactor = weightParams['W_PR'].to_f / 100
                    xi = xi_pr
                    solution = val.to_f * weightFactor / xi
                    if k.include? 'espcp'
                        pumpsHash['ESPCP']['PR'] = [val.to_f, solution]
                    elsif k.include? 'esp'
                        pumpsHash['ESP']['PR'] = [val.to_f, solution]
                    elsif k.include? 'pcp'
                        pumpsHash['PCP']['PR'] = [val.to_f, solution]
                    elsif k.include? 'rrp'
                        pumpsHash['RRP']['PR'] = [val.to_f, solution]
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

                        positiveSep = ( solutions[:best][property[0]] - pump[1][property[0]][1] ) **2
                        pump[1]['positiveSep'] += positiveSep
                    end
                    if solutions[:worst][property[0]]
                        negativeSep = ( solutions[:worst][property[0]] - pump[1][property[0]][1] ) **2
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