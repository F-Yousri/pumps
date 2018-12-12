  class SuckerRodTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input
        SuckerRod.select('yield_strength').where(Weatherford: input).limit(1)
    end 
  end


