require "#{Rails.root}/lib/phasetwo/table_generate.rb"
Dir["#{Rails.root}/app/models/phasetwo/*.rb"].each {|file| require file }
module PhaseTwoPumpTwo
    class << self


        def pumptwo params
            
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
        @data3

        end
        
    end
end