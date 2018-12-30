require "#{Rails.root}/lib/phasetwo/table_generate.rb"
Dir["#{Rails.root}/app/models/phasetwo/*.rb"].each {|file| require file }
module PhaseTwoPumpThree
    class << self


        def pumpthree (params,phaseoneparams)
            @PR_ND=params[:PR_ND].to_f
            @OD_r=0.875 # mina eih ba2a el mo3adla  5od balak lazem .875 or 1.125 or 1 or .75
            @RT=params[:RT] # mina eih ba2a el mo3adla  wala given wala eih 
            @data=TableService.new(Tablegenerate.new('SuckerRodTable').get_table,@RT).final
            @YS_min=@data[0]['yield_strength']
            @SPW_r=TableService.new(Tablegenerate.new('RodStringTaperingPercentagesTable').get_table,{SR_ND: @PR_ND,pump: 3}).final
            @P_DL=phaseoneparams[:WGD].to_f*phaseoneparams[:VD_pump].to_f*phaseoneparams[:SG_m].to_f
            @P_IL=phaseoneparams[:WGD].to_f*(phaseoneparams[:VD_pump].to_f-phaseoneparams[:VD_FL].to_f)*phaseoneparams[:SG_m].to_f
            @P_G=phaseoneparams[:GGD].to_f*phaseoneparams[:SG_g].to_f*phaseoneparams[:VD_FL].to_f
            @rho_m=phaseoneparams[:SG_m].to_f*62.4
            @TBG_ID=2.441 #mina gat menen
            @Re=1.478*phaseoneparams[:GQ].to_f*@rho_m/(phaseoneparams[:meo_m].to_f*(@TBG_ID+@OD_r))
            if(@Re>2100)
                @FR='Turbelant Flow'
            else
                @FR='Laminar Flow'
            end
            @P_losses=302.179  # mina eih ba2a el mo3adla 
            @P_d=phaseoneparams[:WHP].to_f+@P_DL+@P_losses
            @P_i=phaseoneparams[:CHP].to_f+@P_G+@P_IL
            @C_min=params[:C_min].to_f
            @PCNL=(@P_d-@P_i)/@C_min
            @H_PCP=1500 #PCNL/(phaseoneparams[:WGD].to_f*phaseoneparams[:SG_m].to_f)
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
            @N_pcpm=350 #mina mesh 3aref gom menen
            @Eff_pcp=0.7 #mina mesh 3aref gom mnen
            @V_min=100*phaseoneparams[:GQ].to_f/(@N_pcpm*@Eff_pcp)
            @data2=TableService.new(Tablegenerate.new('PcpTable').get_table,{H_PCP:@H_PCP ,Imperial_Q:@rpm,V_min:@V_min}).final
            #mina feh moshkela kbera hena fe el gadwal
            @IH_PCP=@data2[:IH_PC]
            @IQ_PCP=@data2[:IQ_PCP]
            @e=@data2[:e]
            @d_r=@data2[:d_r]
            @T_bh=phaseoneparams[:T_bh].to_f
            @GLR=769.231 #mina gat menen
            @API=phaseoneparams[:API].to_f
            @ArP='Moderate' #mina gat menen
            @AP='Moderate' #mina gat menen  w eih el 27tmalat tany 8er  Moderate
            @CP='Moderate'  #mina gat menen
            @data3=TableService.new(Tablegenerate.new('StatorTable').get_table,{T_bh:@T_bh,GLR:@GLR,API:@API,ArP:@ArP,AP:@AP,CP:@CP}).final
            @stator_type=@data3[:elastomer_type]
            @PW_r=@SPW_r*phaseoneparams[:VD_pump].to_f
            @A_PCP=4*@e*@d_r
            @PAL=@A_PCP*@PCNL
            @AL=@PAL+@PW_r 
            @Tao_h=(8.97e-4)*@IQ_PCP*@PCNL
            @Tao_p=@data2[:hydraulic_torque]
            @Tlim=TableService.new(Tablegenerate.new('RodTypeTorquLimitTable').get_table,{OD_r:@OD_r,RT:@RT}).final #mina
            @T_tot=@Tao_h*(1+(@Tao_p.to_f/100))
            @S_e=Math.sqrt(0.000016*@AL**2/Math::PI**2/@OD_r**4+0.1106*@T_tot**2/Math::PI**2/@OD_r**6)
            @HHP_PCP=1.94e-4*@T_tot*@N_pcpm
            @MF=params[:MF].to_f
            @Eff_m=params[:Eff_m].to_f
            @MHP_P=@HHP_PCP/(@MF*@Eff_m) #mina el mo3adla sa7 wala eih ?
            @data4=TableService.new(Tablegenerate.new('DriveheadTable').get_table,{T_tot:@T_tot,AL:@AL,MHP_P:@MHP_P}).final
            @SN_pcpm=600
            @ST_tot=@data4[:Torque]
            @TB=@data4[:TB]
            @MHP_Ps=@data4[:MHP_Ps]
            @Drive_Head=@data4[:gm]
            @I_pcp=@MHP_P/(0.002322*phaseoneparams[:V_ml].to_f*@Eff_m*@MF)
            @EC_pcp=1.73*phaseoneparams[:V_ml].to_f*@I_pcp*@MF*365*24*phaseoneparams[:EC].to_f/1000
            @EC_pcp
        end
        
    end
end