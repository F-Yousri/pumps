require "#{Rails.root}/lib/phasetwo/table_generate.rb"
Dir["#{Rails.root}/app/models/phasetwo/*.rb"].each {|file| require file }
module PhaseTwoPumpThree
    class << self


        def pumpthree (params,phaseoneparams)
            @sg_m=(phaseoneparams[:WC].to_f/100.0)*phaseoneparams[:SG_w].to_f+(1-(phaseoneparams[:WC].to_f/100.0))*phaseoneparams[:SG_o].to_f
            @PR_ND=phaseoneparams[:PR_ND].to_f
            @PR_ND = TableService.new(Tablegenerate.new('MatchTable').get_table,@PR_ND).final
            @PR_ND=@PR_ND.to_f
            if @PR_ND == 66
            @PR1_ND=6.0/8.0
            elsif  @PR_ND == 77
            @PR1_ND=0.875  
            elsif  @PR_ND == 88
            @PR1_ND=1.0        
            else
            @PR1_ND=1.125   
            end 
            @RT=phaseoneparams[:RT] 
            @data=TableService.new(Tablegenerate.new('SuckerRodTable').get_table,@RT).final
            @YS_min=@data[0]['yield_strength']
            @SPW_r=TableService.new(Tablegenerate.new('RodStringTaperingPercentagesTable').get_table,{SR_ND: @PR_ND,pump: 3}).final
            @P_DL=phaseoneparams[:WGD].to_f*phaseoneparams[:VD_pump].to_f*@sg_m
            @P_IL=phaseoneparams[:WGD].to_f*(phaseoneparams[:VD_pump].to_f-phaseoneparams[:VD_FL].to_f)*@sg_m
            @P_G=phaseoneparams[:GGD].to_f*phaseoneparams[:SG_g].to_f*phaseoneparams[:VD_FL].to_f
            @rho_m=@sg_m*62.4
            if (  phaseoneparams[:TBG_ND].to_f == 119 )
                @TBG_ID=1.995
            elsif (  phaseoneparams[:TBG_ND].to_f == 120 )
                @TBG_ID=2.441
            elsif (  phaseoneparams[:TBG_ND].to_f == 121 )
                @TBG_ID=2.992
            elsif (  phaseoneparams[:TBG_ND].to_f == 122 )
                @TBG_ID=3.958
            end
            @Re=1.478*phaseoneparams[:GQ].to_f*@rho_m/(phaseoneparams[:meo_m].to_f*(@TBG_ID+@PR1_ND))
            if(@Re>2100)
                @FR='Turbelant Flow'
            else
                @FR='Laminar Flow'
            end
            if ( @FR == 'Laminar Flow' )
                @P_losses = (0.00000796* phaseoneparams[:GQ].to_f * phaseoneparams[:VD_pump].to_f * phaseoneparams[:meo_m].to_f )/((@TBG_ID - @PR1_ND)**2 * (@TBG_ID **2 - @PR1_ND**2))
            else
                @P_losses=( 0.00000004317 * phaseoneparams[:GQ].to_f**1.8 * phaseoneparams[:VD_pump].to_f * phaseoneparams[:meo_m].to_f**0.2 * @rho_m**0.8)/((@TBG_ID - @PR1_ND)**1.2 * (@TBG_ID**2 - @PR1_ND**2)**1.8 )
            end
            @P_d=phaseoneparams[:WHP].to_f+@P_DL+@P_losses
            @P_i=phaseoneparams[:CHP].to_f+@P_G+@P_IL
            @C_min=phaseoneparams[:C_min].to_f / 100.0
            @PCNL=(@P_d-@P_i)/@C_min
            @H_PCP=@PCNL/(phaseoneparams[:WGD].to_f*@sg_m)
            @AP=phaseoneparams[:AP].to_f
            @AP = TableService.new(Tablegenerate.new('MatchTable').get_table,@AP).final
            @meo_m=phaseoneparams[:meo_m].to_f
            @data5=TableService.new(Tablegenerate.new('PcpConditionTable').get_table,{AP:@AP , meo_m:@meo_m}).final
            @rpm=@data5['rpm']
            @Eff_pcp=@data5['eff_pcp']
            @V_min=100*phaseoneparams[:GQ].to_f/(@rpm*@Eff_pcp /100.0)
            @data2=TableService.new(Tablegenerate.new('PcpTable').get_table,{H_PCP:@H_PCP ,Imperial_Q:@rpm,V_min:@V_min}).final
            @IH_PCP=@data2[:IH_PC]
            @IQ_PCP=@data2[:IQ_PCP]
            @e=@data2[:e]
            @d_r=@data2[:d_r]
            @T_bh=phaseoneparams[:T_bh].to_f
            @GLR=phaseoneparams[:GLR].to_f
            @API=phaseoneparams[:API].to_f
            @ArP=phaseoneparams[:ArP].to_f
            @CP=phaseoneparams[:CP].to_f
            @AP=phaseoneparams[:AP].to_f
            @data3=TableService.new(Tablegenerate.new('StatorTable').get_table,{T_bh:@T_bh,GLR:@GLR,API:@API,ArP:@ArP,AP:@AP,CP:@CP}).final
            @stator_type=@data3[:elastomer_type]
            @PW_r=@SPW_r*phaseoneparams[:VD_pump].to_f
            @A_PCP=4*@e*@d_r
            @PAL=@A_PCP*@PCNL
            @AL=@PAL+@PW_r 
            @Tao_h=(8.97e-4)*@IQ_PCP*@PCNL
            @Tao_p=@data2[:hydraulic_torque]
            @Tlim=TableService.new(Tablegenerate.new('RodTypeTorquLimitTable').get_table,{OD_r:@PR1_ND,RT:@RT}).final #mina
            @Tlim=@Tlim[0]
            @T_tot=@Tao_h*(1+(@Tao_p.to_f/100))
            @S_e=Math.sqrt(0.000016*@AL**2/Math::PI**2/@PR1_ND**4+0.1106*@T_tot**2/Math::PI**2/@PR1_ND**6)
            @HHP_PCP=1.94e-4*@T_tot*@rpm
            @MF=phaseoneparams[:MF].to_f
            @Eff_m=phaseoneparams[:m_eff].to_f
            @MHP_P=@HHP_PCP/(@MF*@Eff_m) #mina el mo3adla sa7 wala eih ?
            @data4=TableService.new(Tablegenerate.new('DriveheadTable').get_table,{T_tot:@T_tot,AL:@AL,MHP_P:@MHP_P}).final
            @SN_pcpm=600
            @ST_tot=@data4[:Torque]
            @TB=@data4[:TB]
            @MHP_Ps=@data4[:MHP_Ps]
            @Drive_Head=@data4[:gm]
            @I_pcp=@MHP_P/(0.002322*phaseoneparams[:V_ml].to_f*@Eff_m*@MF)
            @EC_pcp=1.73*phaseoneparams[:V_ml].to_f*@I_pcp*@MF*365*24*phaseoneparams[:EC].to_f/1000
            {
                sg_m: @sg_m,
                PR_ND: @PR_ND,
                PR1_ND: @PR1_ND,
                PR1_ND: @PR1_ND,
                YS_min: @YS_min,
                SPW_r:@SPW_r,
                P_DL:@P_DL,
                P_IL:@P_IL,
                P_G: @P_G,
                rho_m:@rho_m,
                TBG_ID: @TBG_ID,
                Re: @Re,
                FR: @FR,
                P_losses:@P_losses,
                P_d: @P_d,
                P_i:@P_i,
                C_min:@C_min,
                PCNL:@PCNL,
                H_PCP: @H_PCP,
                AP:@AP,
                meo_m: @meo_m,
                rpm:@rpm,
                Eff_pcp: @Eff_pcp,
                V_min: @V_min,
                IH_PCP:@IH_PCP,
                IQ_PCP: @IQ_PCP,
                e: @e,
                d_r:@d_r,
                stator_type:@stator_type,
                PW_r: @PW_r,
                A_PCP:@A_PCP,
                PAL:@PAL,
                AL:@AL,
                Tao_h:@Tao_h,
                Tao_p:@Tao_p,
                Tlim:@Tlim,
                T_tot:@T_tot,
                S_e:@S_e,
                HHP_PCP:@HHP_PCP,
                MHP_P:@MHP_P,
                SN_pcpm:@SN_pcpm,
                ST_tot:@ST_tot,
                TB:@TB,
                MHP_Ps:@MHP_Ps,
                Drive_Head: @Drive_Head,
                I_pcp: @I_pcp,
                EC_pcp: @EC_pcp
            }
        end
        
    end
end