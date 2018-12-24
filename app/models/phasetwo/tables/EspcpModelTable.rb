  class EspcpModelTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data params
        data=EspcpModel.select('head').where(pump_rating: params[:Model]).where("minrate < ?", params[:V_espcpmin]).where("maxrate > ?", params[:V_espcpmin]).limit(1)
    end 
  end


#   {
#     "EH_PCP": 1396.791,
#     "Model": "EVONB5A",
#     "V_espcpmin": 812.5
# }

#{EH_PCP:@EH_PCP,Model:@Model,V_espcpmin:@V_espcpmin}
