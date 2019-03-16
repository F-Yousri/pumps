  class EspcpModelTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data params
        @check=EspcpModel.select('flow_rate750_to').where(pump_rating: params[:Model]).order("flow_rate750_to DESC").first
        if ( params[:V_espcpmin] >= @check[:flow_rate750_to])
          params[:V_espcpmin] =  @check[:flow_rate750_to]
        end
        @check2=EspcpModel.select('flow_rate350_from').where(pump_rating: params[:Model]).order("flow_rate350_from ASC").first
        if ( params[:V_espcpmin] <=  @check2[:flow_rate350_from])
          params[:V_espcpmin] =  @check2[:flow_rate350_from]
        end
        @allhead=EspcpModel.select('head').where(pump_rating: params[:Model]).where("flow_rate350_from <= ?", params[:V_espcpmin]).where("flow_rate750_to >= ?", params[:V_espcpmin]).map(&:head)
        @new=@allhead.sort 
        @head=@new.find { |e| e > params[:EH_PCP] }
        @data=EspcpModel.where(pump_rating: params[:Model]).where(head:@head)
        @data[0]
    end 
  end

