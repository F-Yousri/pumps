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
        render json:  @params
        # phasetwo params
    end

    def phasetwo  
        @SR_ND=params[:SR_ND]
        @SR1_ND=1
        @RT='D'
        data = TableService.new(Tablegenerate.new('SuckerRodTable').get_table,@RT).final
        @YS_min=data[0]['yield_strength']
        @SL=120
        @N_SRP=10
        @ID_SRP=2.155
        @ID_p = TableService.new(Tablegenerate.new('AvailableSuckerRodPumpSize').get_table,@ID_SRP).final
        @array=TableService.new(Tablegenerate.new('RodStringTaperingPercentagesTable').get_table,{ID_p: @ID_p,SR_ND: @SR_ND}).final
        @R1= @array[0]['size_118']
        @R2=@array[0]['size_1']
        @R3=@array[0]['size_78']
        @R4=@array[0]['size_34']
        @SW_r=@array[0]['Rod_Weight']
        @L_p=5
        @L_spacing=54
        @L_b=19.5
        @L_bs = TableService.new(Tablegenerate.new('BarrelSizesTable').get_table,@L_b).final
        @Delta=0.170
        @W_r=8585.500
        @Fo=6093.600
        @PPRL=16140.462
        @S_axial=20550.674
        @MPRL=6012.820
        @PT=303829.271
        @L_bs = TableService.new(Tablegenerate.new('BarrelSizesTable').get_table,@L_b).final

    end
end
# ESP_Performance_Curves