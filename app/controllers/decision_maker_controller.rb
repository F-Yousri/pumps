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
        @array=TableService.new(Tablegenerate.new('RodStringTaperingPercentagesTable').get_table,{ID_p: @ID_p,SR_ND: @SR_ND,pump: 2}).final
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
        @data2=TableService.new(Tablegenerate.new('ESPMotorSpecification').get_table,{HP_ESPm: @HP_ESPm,series:@series}).final
        @HP_ESPsm=@data2[:hp]
        @V_ESPsm=@data2[:Voltage]
        @I_ESPsm=@data2[:Amperage]
        @x1=86
        @x2=769.231
        @x3='Moderate'
        @data3=TableService.new(Tablegenerate.new('ElectricalCable').get_table,{maxTemp:@x1,gasResistanceIndex:@x2,CorrosionResistance:@x3}).final
        @ML=97.54
        @PCT=@data3[:model]
        @a_c6=@data3[:a6]
        @a_c4=@data3[:a4]
        @a_c2=@data3[:a2]
        @a_c1=@data3[:a1]
        @T_c6=103.188
        @T_c4=96.188
        @T_c2=92
        @T_c1=90.313
        @dV6=17.601
        @dV4=17.351
        @dV2=17.202
        @dV1=17.141
        @L_sl=17.601
        @CL=4200
        @V_surf=531.602
        @kVA_surf=25.320
        @sjb=TableService.new(Tablegenerate.new('JunctionBoxselectionTable').get_table,@V_surf).final
        @ssb='2C-CG'
        # @kVA_SB
        # @kVA_t
        # @EC_esp

    end
 

    def phaseTwoPump3
        @PR_ND=77
        @OD_r=0.87
        @RT='D'
        @data=TableService.new(Tablegenerate.new('SuckerRodTable').get_table,@RT).final
        @YS_min=@data[0]['yield_strength']
        @SPW_r=TableService.new(Tablegenerate.new('RodStringTaperingPercentagesTable').get_table,{SR_ND: @PR_ND,pump: 3}).final
        @P_DL=1532.565
        @P_IL=1094.690
        @P_G=0.805
        @rho_m=63.103
        @Re=86.032
        @FR='Laminar Flow'
        @P_losses=302.179
        @P_d=1894.744
        @P_i=1150.495
        @C_min=90.00
        @PCNL=826.944
        # @H_PCP=1888.535
        @H_PCP=1500 #mina
        @conditions="Moderate"
        @meo_m=212.5  #mina
        if(@conditions == "No or Minor")
            @Eff_pcp=85
            if (@meo_m < 500)
                @rpm=500
            elsif (@meo_m.between?(500, 5000))
                @rpm=400
            else 
                @rpm=250
            end
        else
            @rpm=TableService.new(Tablegenerate.new('PcpConditionTable').get_table,@conditions).final
        end
        @data2=TableService.new(Tablegenerate.new('PcpTable').get_table,{H_PCP:@H_PCP ,Imperial_Q:@rpm}).final
        @IH_PCP=@data2[:IH_PC]
        @e=@data2[:e]
        @d_r=@data2[:d_r]
        @T_bh=86
        @GLR=769.231
        @API=35
        @ArP='Moderate'
        @AP='Moderate'
        @CP='Moderate'
        @data3=TableService.new(Tablegenerate.new('StatorTable').get_table,{T_bh:@T_bh,GLR:@GLR,API:@API,ArP:@ArP,AP:@AP,CP:@CP}).final
        @stator_type=@data3[:elastomer_type]
        @PW_r=7784
        @A_PCP=1.892
        @PAL=1564.578
        @AL=9348.578
        @Tao_h=259.619
        @Tao_p=@data2[:hydraulic_torque]
        @mina=TableService.new(Tablegenerate.new('RodTypeTorquLimitTable').get_table,{OD_r:@OD_r,RT:@RT}).final #mina
        @Tlim=735
        @S_e=59.501
        @HHP_PCP=24.679
        @MF=0.890
        @Eff_m=0.920
        @MHP_P=30.141

        render json:@mina

    end
end
