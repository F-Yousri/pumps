class DecisionMakerController < ApplicationController
    require "#{Rails.root}/lib/phasetwo/table_generate.rb"
    require "#{Rails.root}/app/services/phasetwo/table_service.rb"
    skip_before_action :verify_authenticity_token  

    def techEvalForm        
    end

    def techEval
        # session[:params] ||= params
        @params = DecisionMakerService.make(params)
        # session[:result] ||= @params
        # render json:  @params
        phasetwo params
    end

    def phasetwo  params
        SR_ND=params[:SR_ND]
        SR_ND1=1
        RT='D'

        # params = session[:params] 
        data = TableService.new(Tablegenerate.new('mina').get_table,params['WC']).final
        data2 = TableService.new(Tablegenerate.new('fahd').get_table,50).final
        render json:  data2
    end
end
ESP_Performance_Curves