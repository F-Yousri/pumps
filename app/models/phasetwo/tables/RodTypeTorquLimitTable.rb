  class RodTypeTorquLimitTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input
        @data=RodTypeTorquLimit.where(API: input[:OD_r]).where(Weatherford: input[:RT])
        @data
    end 
  end


