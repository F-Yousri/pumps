  class EspPerformanceCurfTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input
        @data=EspPerformanceCurf.where(pump_seris: input[:series]).where("minrate < ?", input[:V_t]).where("maxrate > ?", input[:V_t]).first
    end 
  end


