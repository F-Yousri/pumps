require "#{Rails.root}/lib/phasetwo/table_generate.rb"
Dir["#{Rails.root}/app/models/phasetwo/*.rb"].each {|file| require file }
module PhaseTwoPumpFour
    class << self


        def pumpfour (params,phaseoneparams)
            @P_DL=phaseoneparams[:WGD].to_f*phaseoneparams[:VD_pump].to_f*phaseoneparams[:SG_m].to_f
            @P_IL=phaseoneparams[:WGD].to_f*(phaseoneparams[:VD_pump].to_f-phaseoneparams[:VD_FL].to_f)*phaseoneparams[:SG_m].to_f
            @P_G=phaseoneparams[:GGD].to_f*phaseoneparams[:SG_g].to_f*phaseoneparams[:VD_FL].to_f
            @rho_m=phaseoneparams[:SG_m].to_f*62.4
            @TBG_ID=2.441 #mina gat menen
            @ERe=1.478*phaseoneparams[:GQ].to_f*@rho_m/(phaseoneparams[:meo_m].to_f*@TBG_ID)
            if(@ERe>2100) #mina hia Re wala ERe
                @FR='Turbelant Flow'
            else
                @FR='Laminar Flow'
            end
            @EFR="Laminar Flow"
            @EP_losses=108.388 #mina eih ba2a el mo3adla
            @EP_d=phaseoneparams[:WHP].to_f+@P_DL+@EP_losses
            @P_i=phaseoneparams[:CHP].to_f+@P_G+@P_IL
            @C_min=params[:C_min].to_f
            @PCNL=(@EP_d-@P_i)/@C_min
            @EH_PCP=@PCNL/(phaseoneparams[:WGD].to_f*phaseoneparams[:SG_m].to_f)
            @Eff_espcp=params[:Eff_espcp].to_f
            @V_espcpmin=phaseoneparams[:GQ].to_f/@Eff_espcp
            @TL=phaseoneparams[:VD_pump].to_f*phaseoneparams[:WGD].to_f*phaseoneparams[:SG_m].to_f*Math::PI/4*@TBG_ID**2/1000
            @data1=TableService.new(Tablegenerate.new('EspcpTable').get_table,@TL).final
            @TC_s=@data1[:TC_s]
            @Model=@data1[:model]
            @data=TableService.new(Tablegenerate.new('EspcpModelTable').get_table,{EH_PCP:@EH_PCP,Model:@Model,V_espcpmin:@V_espcpmin}).final
            @Rating=@data[:pump_rating]
            @ESPCP_350Q=@data[:flow_rate350_from]
            @ESPCP_750Q=@data[:flow_rate750_to]
            @ESPCP_500Q=@data[:flow_rate500]
            @N_ESPCP=516.858  #mina eih ba2a el mo3adla
            @IH_ESPCP=@data[:head]
            @MHP_espcp=@data[:motor_power]
            @V_espcp=@data[:Voltage]
            @I_espcp=@data[:Current]
            @PF_espcp=@data[:power_factor]
            @T_bh=phaseoneparams[:T_bh].to_f
            @GLR=769.231 #mina gat menen
            @API=phaseoneparams[:API].to_f
            @ArP='Moderate' #mina gat menen
            @AP='Moderate' #mina gat menen  w eih el 27tmalat tany 8er  Moderate
            @CP='Moderate'  #mina gat menen
            @data2=TableService.new(Tablegenerate.new('StatorTable').get_table,{T_bh:@T_bh,GLR:@GLR,API:@API,ArP:@ArP,AP:@AP,CP:@CP}).final
            @stator_type=@data2[:elastomer_type]
            @data3=TableService.new(Tablegenerate.new('ElectricalCable').get_table,{maxTemp:@T_bh,gasResistanceIndex:@GLR,CorrosionResistance:@CP}).final
            @type=@data3[:model]
            @a_c6=@data3[:a6]
            @a_c4=@data3[:a4]
            @a_c2=@data3[:a2]
            @a_c1=@data3[:a1]
            @T_c6=@a_c6*@I_ESPCP**2+@T_bh
            @T_c4=@a_c4*@I_ESPCP**2+@T_bh
            @T_c2=@a_c2*@I_ESPCP**2+@T_bh
            @T_c1=@a_c1*@I_ESPCP**2+@T_bh
            @dV6=(2.0/3.0)*@I_ESPCP*(1+0.00214*(@T_c6-77))
            @dV4=(5.0/11.0)*@I_ESPCP*(1+0.00214*(@T_c4-77))
            @dV2=(3.0/11.0)*@I_ESPCP*(1+0.00214*(@T_c2-77))
            @dV1=(3.0/14.0)*@I_ESPCP*(1+0.00214*(@T_c1-77))
            @L_sl=100
            @CL=4200.000
            @V_surfe=1091.916
            @HP_surfe=51.254
            @vfs=TableService.new(Tablegenerate.new('VfsTable').get_table,@HP_surfe).final
            @kVA_espcp=51.062
            @sjb=TableService.new(Tablegenerate.new('JunctionBoxselectionTable').get_table,@V_surfe).final
            @st=TableService.new(Tablegenerate.new('TransformerTable').get_table,@HP_surfe).final
            @EC_espcp=11501.548
    
            @data3
    
        end
        
    end
end