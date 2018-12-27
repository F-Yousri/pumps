require "#{Rails.root}/lib/phasetwo/table_generate.rb"
Dir["#{Rails.root}/app/models/phasetwo/*.rb"].each {|file| require file }
module PhaseTwoPumpThree
    class << self


        def pumpthree params
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
            @T_tot=363.467
            @Tlim=735
            @S_e=59.501
            @HHP_PCP=24.679
            @MF=0.890
            @Eff_m=0.920
            @MHP_P=30.141
            @data4=TableService.new(Tablegenerate.new('DriveheadTable').get_table,{T_tot:@T_tot,AL:@AL,MHP_P:@MHP_P}).final
            @SN_pcpm=600
            @ST_tot=@data4[:Torque]
            @TB=@data4[:TB]
            @MHP_Ps=@data4[:MHP_Ps]
            @Drive_Head=@data4[:gm]
            @I_pcp=33.027
            @EC_pcp=13043.269
        end
        
    end
end