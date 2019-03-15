  class StatorTable

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input   #{T_bh:@T_bh,GLR:@GLR,API:@API,ArP:@ArP,AP:@AP,CP:@CP}
    @data=Stator.where("max_temp >= ?", input[:T_bh])
    .where("glr >= ?" ,input[:GLR])
    if ( @data != nil)
      @data1=Stator.where("max_temp >= ?", input[:T_bh])
      .where("glr >= ?" ,input[:GLR])
      .where("aromatics >=  ?", input[:ArP])
      .where("corrosives_resistance >=  ?", input[:CP])
    end
    if ( @data1 != nil)
      @data2=Stator.where("max_temp >= ?", input[:T_bh])
      .where("glr >= ?" ,input[:GLR])
      .where("aromatics >=  ?", input[:ArP])
      .where("corrosives_resistance >=  ?", input[:CP])
      .where("api_index >=  ?", input[:AP])
    end
    if ( @data2 != nil)
      @data3=Stator.where("max_temp >= ?", input[:T_bh])
      .where("glr >= ?" ,input[:GLR])
      .where("aromatics >=  ?", input[:ArP])
      .where("corrosives_resistance >=  ?", input[:CP])
      .where("api_index >=  ?", input[:AP])
      .or(Stator.where("max_temp >= ?", input[:T_bh])
      .where("glr >= ?" ,input[:GLR])
      .where("aromatics >=  ?", input[:ArP])
      .where("corrosives_resistance >=  ?", input[:CP])
      .where("api_index >=  ?", input[:AP])
      .where("oil_api_from <= ?",input[:API])
      .where("oil_api_to >= ?", input[:API]))
      
    end

    if ( @data3.length > 0)
    return @data3.order(:price_factor).first
    end
    if ( @data2.length > 0)
      return @data2.order(:price_factor).first
    end 
    if ( @data1.length > 0)
      return @data1.order(:price_factor).first
    end 
    if (@data.length> 0)
      return @data.order(:price_factor).first
    end
  end
end