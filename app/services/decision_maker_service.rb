module DecisionMakerService
    class << self


        def make params
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
    end
end