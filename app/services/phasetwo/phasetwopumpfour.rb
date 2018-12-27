require "#{Rails.root}/lib/phasetwo/table_generate.rb"
Dir["#{Rails.root}/app/models/phasetwo/*.rb"].each {|file| require file }
module PhaseTwoPumpFour
    class << self


        def pumpfour params
            @P_DL=1532.565
            @P_IL=1094.690
            @P_G=0.805
            @rho_m=63.103
            @ERe=116.872
            @EFR="Laminar Flow"
            @EP_losses=108.388
            @EP_d=1700.954
            @P_i=1150.495
            @C_min=0.900
            @PCNL_e=611.621
            @EH_PCP=1396.791
            @Eff_espcp=80%
            @V_espcpmin=812.500
            @TL=7.172
            @data1=TableService.new(Tablegenerate.new('EspcpTable').get_table,@TL).final
            @TC_s=@data1[:TC_s]
            @Model=@data1[:model]
            @data=TableService.new(Tablegenerate.new('EspcpModelTable').get_table,{EH_PCP:@EH_PCP,Model:@Model,V_espcpmin:@V_espcpmin}).final
            @Rating=@data[:pump_rating]
            @ESPCP_350Q=@data[:flow_rate350_from]
            @ESPCP_750Q=@data[:flow_rate750_to]
            @ESPCP_500Q=@data[:flow_rate500]
            @N_ESPCP=516.858
            @IH_ESPCP=@data[:head]
            @MHP_espcp=@data[:motor_power]
            @V_espcp=@data[:Voltage]
            @I_espcp=@data[:Current]
            @PF_espcp=@data[:power_factor]
            @T_bh=86
            @GLR=769.231
            @API=35
            @ArP='Moderate'
            @AP='Moderate'
            @CP='Moderate'
            @data2=TableService.new(Tablegenerate.new('StatorTable').get_table,{T_bh:@T_bh,GLR:@GLR,API:@API,ArP:@ArP,AP:@AP,CP:@CP}).final
            @stator_type=@data2[:elastomer_type]
            @x1=86
            @x2=769.231
            @x3='Moderate'
            @data3=TableService.new(Tablegenerate.new('ElectricalCable').get_table,{maxTemp:@x1,gasResistanceIndex:@x2,CorrosionResistance:@x3}).final
            @type=@data3[:model]
            @a_c6=@data3[:a6]
            @a_c4=@data3[:a4]
            @a_c2=@data3[:a2]
            @a_c1=@data3[:a1]
            @T_c6=106.048
            @T_c4=97.883
            @T_c2=92.998
            @T_c1=91.030
            @dV6=19.119
            @dV4=18.804
            @dV2=18.616
            @dV1=18.540
            @L_sl=100
            @CL=4200.000
            @V_surfe=1091.916
            @HP_surfe=51.254
            @vfs=TableService.new(Tablegenerate.new('VfsTable').get_table,@HP_surfe).final
            @kVA_espcp=51.062
            @sjb=TableService.new(Tablegenerate.new('JunctionBoxselectionTable').get_table,@V_surfe).final
            @st=TableService.new(Tablegenerate.new('TransformerTable').get_table,@HP_surfe).final
            @EC_espcp=11501.548
    
            @sjb
    
        end
        
    end
end