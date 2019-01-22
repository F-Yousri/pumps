class EconomicWeightTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input
       @data=EconomicWeight.where(factor: input)
       @data[0][:weight]
    end 
  end
