  class StatorTable

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input   #{T_bh:@T_bh,GLR:@GLR,API:@API,ArP:@ArP,AP:@AP,CP:@CP}
    @data=Stator.where("max_temp >= ?", input[:T_bh])
    .where("aromatics >=  ?", input[:ArP])
    .where("api_index >=  ?", input[:AP])
    .where("corrosives_resistance >=  ?", input[:CP])
    .where("glr >= ?" ,input[:GLR])
    .where("oil_api_from <= ?",input[:API])
    .where("oil_api_to >= ?", input[:API])
    @data[0]
    end 
  end