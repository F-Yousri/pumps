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

    def phaseTwoPump1
        @SR_ND=params[:SR_ND]
        @SR1_ND=1
        @RT=params[:RT]
        data = TableService.new(Tablegenerate.new('SuckerRodTable').get_table,@RT).final
        @YS_min=data[0]['yield_strength']
        @SL=params[:SL]
        @N_SRP=params[:N_SRP]
        @ID_SRP=2.155
        @ID_p = TableService.new(Tablegenerate.new('AvailableSuckerRodPumpSize').get_table,@ID_SRP).final
        @array=TableService.new(Tablegenerate.new('RodStringTaperingPercentagesTable').get_table,{ID_p: @ID_p,SR_ND: @SR_ND}).final
        @R1= @array[0]['size_118']
        @R2=@array[0]['size_1']
        @R3=@array[0]['size_78']
        @R4=@array[0]['size_34']
        @SW_r=@array[0]['Rod_Weight']
        @PEff_srp=params[:PEff_srp]
        @MEff_srp=params[:MEff_srp]
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
        @data = TableService.new(Tablegenerate.new('AvailablePumpingUnitTable').get_table,{PT: @PT,PPRL: @PPRL}).final
        @PPRL100=@data[:PPRL100]
        @PT1000=@data[:PT1000]
        @SL=@data[:SL]
        @MHP_srp=64.468
        @L_bs = TableService.new(Tablegenerate.new('NemaTable').get_table,@MHP_srp).final
    end


    def phaseTwoPump2

        @PIP  = 1532.565
        @V_o =178.750
        @V_w = 487.500
        @Q_gt = 500
        @Q_gs = 32.5
        @Q_gf = 467.5
        @V_g = 16.363
        @V_t = 682.613
        @fgas  = 2.397
        @GHE = 'NO GAS'
        @SG_comp = 1.127
        @H_L = 358.962
        @H_WHP = 10.248
        @F_t = 4.918
        @H_f = 17.213
        @TDH = 386.423
        @series='series400'
        @array=TableService.new(Tablegenerate.new('EspPerformanceCurfTable').get_table,{V_t: @V_t,series: @series  }).final
        @type=@array[:pump_type]
        @HC1=@array[:c1head]
        @HC2=@array[:c2head]
        @HC3=@array[:c3head]
        @HC4=@array[:c4head]
        @HC5=@array[:c5head]
        @HC6=@array[:c6head]
        @HPC1=@array[:c1hp]
        @HPC2=@array[:c2hp]
        @HPC3=@array[:c3hp]
        @HPC4=@array[:c4hp]
        @HPC5=@array[:c5hp]
        @HPC6=@array[:c6hp]
        @Hst=24.391
        @HPst=0.212
        @No_st=16
        @ESP_Eff=57.750
        @data=TableService.new(Tablegenerate.new('HouseTable').get_table,{No_st:@No_st,type:@type}).final
        @SH_st=@data[:No_st]
        @HN=@data[:housing]
        @HP_ESP=16.721
        @HP_seal=0.836
        @HP_AGH=0
        @HP_ESPm=17.558
        @data2=TableService.new(Tablegenerate.new('HouseTable').get_table,{No_st:@No_st,type:@type}).final
        # @HP_ESPsm
        # @V_ESPsm
        # @I_ESPsm
        # @ML
        # @PCT
        # @a_c6
        # @a_c4
        # @a_c2
        # @a_c1
        # @T_c6
        # @T_c4
        # @T_c2
        # @T_c1
        # @dV6
        # @dV4
        # @dV2
        # @dV1
        # @L_sl
        # @CL
        # @V_surf
        # @kVA_surf
        # @kVA_SB
        # @kVA_t
        # @EC_esp

    end
end
