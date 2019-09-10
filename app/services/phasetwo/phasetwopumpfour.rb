require "#{Rails.root}/lib/phasetwo/table_generate.rb"
Dir["#{Rails.root}/app/models/phasetwo/*.rb"].each {|file| require file }
module PhaseTwoPumpFour
    class << self


        def pumpfour (params,phaseoneparams)
            @sg_m=(phaseoneparams[:WC].to_f/100.0)*phaseoneparams[:SG_w].to_f+(1-(phaseoneparams[:WC].to_f/100.0))*phaseoneparams[:SG_o].to_f
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
            @ERe=1.478*phaseoneparams[:GQ].to_f*@rho_m/(phaseoneparams[:meo_m].to_f*@TBG_ID) #=1.478*GQ*rho_m/(meo_m*TBG_ID)
            if(@ERe>2100)
                @EFR='Turbelant Flow'
            else
                @EFR='Laminar Flow'
            end
            if ( @EFR == 'Laminar Flow' )
                @EP_losses = (0.00000796* phaseoneparams[:GQ].to_f * phaseoneparams[:VD_pump].to_f * phaseoneparams[:meo_m].to_f )/((@TBG_ID )**2 * (@TBG_ID **2 ))
            else
                @EP_losses=( 0.00000004317 * phaseoneparams[:GQ].to_f**1.8 * phaseoneparams[:VD_pump].to_f * phaseoneparams[:meo_m].to_f**0.2 * @rho_m**0.8)/((@TBG_ID)**1.2 * (@TBG_ID**2  )**1.8 )
            end
            @EP_d=phaseoneparams[:WHP].to_f+@P_DL+@EP_losses
            @P_i=phaseoneparams[:CHP].to_f+@P_G+@P_IL
            @C_min=phaseoneparams[:C_min].to_f/100
            @PCNL=(@EP_d-@P_i)/@C_min
            @EH_PCP=@PCNL/(phaseoneparams[:WGD].to_f*@sg_m)
            @SE_espcp = TableService.new(Tablegenerate.new('AdditionalCriteriumTable').get_table,'SE_espcp').final
            @V_espcpmin=phaseoneparams[:GQ].to_f/@SE_espcp
            @TL=phaseoneparams[:VD_pump].to_f*phaseoneparams[:WGD].to_f*@sg_m*Math::PI/4*@TBG_ID**2/1000
            @data1=TableService.new(Tablegenerate.new('EspcpTable').get_table,@TL).final
            @TC_s=@data1[:TC_s]
            @Model=@data1[:model]
            @data=TableService.new(Tablegenerate.new('EspcpModelTable').get_table,{EH_PCP:@EH_PCP,Model:@Model,V_espcpmin:@V_espcpmin}).final
            @Rating=@data[:pump_rating]
            @ESPCP_350Q=@data[:flow_rate350_from]
            @ESPCP_750Q=@data[:flow_rate750_to]
            @ESPCP_500Q=@data[:flow_rate500]
            @V_espcpmin = @data[:flow_rate750_to]
            if ( @V_espcpmin > @ESPCP_500Q )
              @N_ESPCP =  750-((@ESPCP_750Q - @V_espcpmin)* (750-500)/(@ESPCP_750Q -@ESPCP_500Q ))
            else
                @N_ESPCP= 500- ((@ESPCP_500Q - @V_espcpmin)*(500-350)/(@ESPCP_500Q - @ESPCP_350Q))
            end
            @IH_ESPCP=@data[:head]
            @MHP_espcp=@data[:motor_power]
            @V_espcp=@data[:Voltage]
            @I_ESPCP=@data[:Current]
            @PF_espcp=@data[:power_factor]
            @eff_espcp=@data[:Efficiency]
            @espp=@data[:price]
            @T_bh=phaseoneparams[:T_bh].to_f
            @GLR=phaseoneparams[:GLR].to_f
            @API=phaseoneparams[:API].to_f
            @ArP=phaseoneparams[:ArP].to_f
            @CP=phaseoneparams[:CP].to_f
            @AP=phaseoneparams[:AP].to_f
            @data2=TableService.new(Tablegenerate.new('StatorTable').get_table,{T_bh:@T_bh,GLR:@GLR,API:@API,ArP:@ArP,AP:@AP,CP:@CP}).final
            @stator_type=@data2[:elastomer_type]
            @pafc=@data2[:price_factor]
            if (phaseoneparams[:CP].to_f == 49)
                @CP='Moderate'
            elsif ( phaseoneparams[:CP].to_f == 47 || phaseoneparams[:CP].to_f == 48) 
                @CP='Weak'
            elsif ( phaseoneparams[:CP].to_f == 50) 
                @CP='Excellent'
            end
            @data3=TableService.new(Tablegenerate.new('ElectricalCable').get_table,{maxTemp:@T_bh,gasResistanceIndex:@GLR,CorrosionResistance:@CP}).final
            @type=@data3[:model]
            @a_c6=@data3[:a6]
            @a_c4=@data3[:a4]
            @a_c2=@data3[:a2]
            @a_c1=@data3[:a1]
            @Price1=@data3[:price1]
            @Price2=@data3[:price2]
            @Price4=@data3[:price4]
            @Price6=@data3[:price6]
            @T_c6=@a_c6*@I_ESPCP**2+@T_bh
            @T_c4=@a_c4*@I_ESPCP**2+@T_bh
            @T_c2=@a_c2*@I_ESPCP**2+@T_bh
            @T_c1=@a_c1*@I_ESPCP**2+@T_bh
            @dV6=(2.0/3.0)*@I_ESPCP*(1+0.00214*(@T_c6-77))
            @dV4=(5.0/11.0)*@I_ESPCP*(1+0.00214*(@T_c4-77))
            @dV2=(3.0/11.0)*@I_ESPCP*(1+0.00214*(@T_c2-77))
            @dV1=(3.0/14.0)*@I_ESPCP*(1+0.00214*(@T_c1-77))
            @max=0
            if ( @dV1 > @dV2 && @dV1 > @dV4 && @dV1 > @dV6)
                @SC="#1"
                @max=@dV1
            elsif ( @dV2 > @dV1 && @dV2 > @dV4 && @dV2 > @dV6)
                @SC="#2"
                @max=@dV2
            elsif ( @dV4 > @dV1 && @dV4 > @dV2 && @dV4 > @dV6)
                @SC="#4"
                @max=@dV4
            elsif ( @dV6 > @dV1 && @dV6 > @dV2 && @dV6 > @dV4)
                @SC="#6"
                @max=@dV6
            end
            @L_sl=phaseoneparams[:L_sl].to_f
            @SE_espcp = TableService.new(Tablegenerate.new('AdditionalCriteriumTable').get_table,'SE_espcp').final
            @CL=phaseoneparams[:MD_pump].to_f+@L_sl
            @V_surfe=@V_espcp+@max*(phaseoneparams[:MD_pump].to_f/1000.0)
            @Hhp_espcp=@PCNL/(phaseoneparams[:WGD].to_f*@sg_m)*phaseoneparams[:GQ].to_f/@eff_espcp/56000
            @HP_surfe=1.732*@V_surfe*@I_ESPCP*@PF_espcp*@eff_espcp/746.0/100.0 #
            @data4=TableService.new(Tablegenerate.new('VfsTable').get_table,@HP_surfe).final
            @vfs=@data4[:vfs]
            @pfsc=@data4[:price]
            @kVA_espcp=1.732*@V_surfe*@I_ESPCP/1000
            @sjb=TableService.new(Tablegenerate.new('JunctionBoxselectionTable').get_table,@V_surfe).final
            @kv=@sjb[:kv]
            @data5=TableService.new(Tablegenerate.new('TransformerTable').get_table,@HP_surfe).final
            @st=@data5[:kva]
            @trp=@data5[:price]
            @EC_espcp=1.73*phaseoneparams[:V_ml].to_f*@I_ESPCP*@PF_espcp*365*24.0*phaseoneparams[:EC].to_f/1000.0
            {
                sg_m:@sg_m,
                P_DL: @P_DL,
                P_IL:@P_IL,
                P_G:@P_G,
                rho_m: @rho_m,
                TBG_ID: @TBG_ID,
                ERe:@ERe,
                EFR: @EFR,
                EP_losses:@EP_losses,
                EP_d:@EP_d,
                P_i:@P_i,
                C_min:@C_min,
                PCNL:@PCNL,
                EH_PCP:@EH_PCP,
                Eff_espcp:@eff_espcp,
                V_espcpmin:@V_espcpmin,
                Hhp_espcp:@Hhp_espcp,
                TL:@TL,
                data:@data1,
                espp:@espp,
                N_ESPCP:@N_ESPCP,
                data3:@data3,
                T_c6:@T_c6,
                T_c4:@T_c4,
                T_c2:@T_c2,
                T_c1:@T_c1,
                dV6:@dV6,
                dV4:@dV4,
                dV2:@dV2,
                dV1:@dV1,
                SC:@SC,
                I_ESPCP:@I_ESPCP,
                SE_espcp:@SE_espcp,
                CL:@CL,
                V_surfe:@V_surfe,
                max:@max,
                HP_surfe:@HP_surfe,
                vfs:@vfs,
                kVA_espcp:@kVA_espcp,
                sjb:@sjb,
                st:@st,
                EC_espcp:@EC_espcp,
                pafc:@pafc,
                price1:@Price1,
                price2:@Price2,
                price4:@Price4,
                price6:@Price6,
                pfsc:@pfsc,
                trp:@trp,
                mina:@data,
                kv:@kv,
                pump_maodel:@data[:pump_maodel],
                EH_PCP:@EH_PCP,Model:@Model,V_espcpmin:@V_espcpmin,
                stator_type:@stator_type,
                type:@type
               
            }
        end
        
    end
end