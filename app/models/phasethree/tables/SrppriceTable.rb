  class SrppriceTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input
        if (input[:rrpt] == 'Tubing Pump')
        @data=Srpprice.select('tbg_p').where(corrosivity: input[:corrosivity])
        .where(pump_d: input[:ID_p]).map(&:tbg_p)
        
        else
        @data=Srpprice.select('rod_p').where(corrosivity: input[:corrosivity])
        .where(pump_d: input[:ID_p]).map(&:rod_p)
        end
        @data[0]
    end 
  end


