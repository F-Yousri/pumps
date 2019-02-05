  class ElectricalCableTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input
        @data=ElectricalCable.where(corrosionresistance: input[:CorrosionResistance]).where("gasresistanceindex > ?", input[:gasResistanceIndex]).where("maxtemp > ?", input[:maxTemp]).first
        @data
        end 
  end


