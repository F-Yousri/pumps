  class PcpConditionTable

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input  
        @data=PcpCondition.where("abrasives LIKE ?", "%#{input[:AP]}%").where("viscosity_from < ?", input[:meo_m]).where("viscosity_to > ?", input[:meo_m])
        @data[0]
    end 
  end


