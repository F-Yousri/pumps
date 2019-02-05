  class EspcpModelTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data params
        @allhead=EspcpModel.select('head').where(pump_rating: params[:Model]).where("flow_rate350_from < ?", params[:V_espcpmin]).where("flow_rate750_to > ?", params[:V_espcpmin]).map(&:head)
        @new=@allhead.sort 
        @head=@new.find { |e| e > params[:EH_PCP] }
        @data=EspcpModel.where(pump_rating: params[:Model]).where(head:@head)
        @data[0]
    end 
  end


#   {
#     "EH_PCP": 1396.791,
#     "Model": "EVONB5A",
#     "V_espcpmin": 812.5
# }

#{EH_PCP:@EH_PCP,Model:@Model,V_espcpmin:@V_espcpmin}
