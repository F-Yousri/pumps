module DecisionMakerService
    class << self


        def make params
            params = self.mixtureCalc params
        end

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

        def match params
            matrix = PumpProperty::all
            params.each do |k, param|
                params[k] = {params[k]=>matrix.select { |pumpProperty| pumpProperty.property.id == k }}
            end
            params
        end
        
        def check params
            case params['MD']
            when 0..4499
                params['MD'] = "shallow"
            when 4500..5999
                params['MD'] = "intermediate"
            when 6000..10000
                params['MD'] = "deep"
            else
                params['MD'] = "extremely deep"
            end

            case params['WD']
            when 0..19
                params['WD'] = "vertical"
            when 20..49
                params['WD'] = "deviated"
            when 50..79
                params['WD'] = "extremely deviated"
            else
                params['WD'] = "horizontal or extended reach"
            end

            # case params['CSG_ND']
            # when 0..4499
            #     params['MD'] = "shallow"
            # when 4500..5999
            #     params['MD'] = "intermediate"
            # when 6000..10000
            #     params['MD'] = "deep"
            # else
            #     params['MD'] = "extremely deep"
            # end
            case params['DS']
            when 0..6
                params['DS'] = "6"
            else
                params['DS'] = "6-15"
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

            case params['J']
            when 0..0.5
                params['J'] = "0.5"
            else
                params['J'] = "0.51"
            end

            case params['T_bh']
            when 0..149
                params['T_bh'] = "150"
            when 150..249
                params['T_bh'] = "250"
            when 250..399
                params['T_bh'] = "400"
            else
                params['T_bh'] = "401"
            end

            case params['meo_m']
            when 0..199
                params['meo_m'] = "200"
            when 200..499
                params['meo_m'] = "500"
            else
                params['meo_m'] = "501"
            end

            case params['API']
            when 0..14
                params['API'] = "15"
            when 15..34
                params['API'] = "35"
            else
                params['API'] = "36"
            end

            case params['GLR']
            when 0..499
                params['GLR'] = "500"
            when 500..1999
                params['GLR'] = "2000"
            else
                params['GLR'] = "3000"
            end
        end
    end
end