  class RodTypeTorquLimitTable 

    def prepare_input input
        self.get_data input
    end

    def get_data input
        case input[:OD_r] # a_variable is the variable we want to compare
        when 0.875    
            @data=RodTypeTorquLimit.select('t78').where(Weatherford: input[:RT]).map(&:t78)
            @data
        when 0.75  
            @data=RodTypeTorquLimit.select('t34').where(Weatherford: input[:RT]).map(&:t34)
            @data  
        when 1    
            @data=RodTypeTorquLimit.select('t1').where(Weatherford: input[:RT]).map(&:t1)
            @data 
        when 1.125  
            @data=RodTypeTorquLimit.select('t118').where(Weatherford: input[:RT]).map(&:t118)
            @data
        end
    end
  end


