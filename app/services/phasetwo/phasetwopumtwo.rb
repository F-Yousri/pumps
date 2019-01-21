require "#{Rails.root}/lib/phasetwo/table_generate.rb"
Dir["#{Rails.root}/app/models/phasetwo/*.rb"].each {|file| require file }
module PhaseTwoPumpTwo
    class << self


        def pumptwo (params,phaseoneparams)
        @sg_m=(phaseoneparams[:WC].to_f/100.0)*phaseoneparams[:SG_w].to_f+(1-(phaseoneparams[:WC].to_f/100.0))*phaseoneparams[:SG_o].to_f
        @BHP=phaseoneparams[:WGD].to_f*@sg_m*phaseoneparams[:D_perf].to_f
        @PIP  =  @BHP-(phaseoneparams[:WGD].to_f*@sg_m*(phaseoneparams[:D_perf].to_f-phaseoneparams[:VD_pump].to_f))
        @V_o =phaseoneparams[:GQ].to_f*(1-phaseoneparams[:WC].to_f/100.0)*phaseoneparams[:beta_o].to_f
        @V_w = phaseoneparams[:GQ].to_f*phaseoneparams[:WC].to_f/100.0*phaseoneparams[:beta_w].to_f
        @GOR=phaseoneparams[:Q_g].to_f*1000/(phaseoneparams[:GQ].to_f*(1-phaseoneparams[:WC].to_f/100.0))
        @Q_gt = phaseoneparams[:GQ].to_f*(1-phaseoneparams[:WC].to_f/100.0)*@GOR/1000.0
        if (phaseoneparams[:R_s].to_f > @GOR)
        else
        @Q_gs=(phaseoneparams[:GQ].to_f*(1-phaseoneparams[:WC].to_f/100.0)*phaseoneparams[:R_s].to_f)/1000.0
        @Q_gf=@Q_gt-@Q_gs
        @V_g=@Q_gf*phaseoneparams[:beta_g].to_f
        end
        @V_t = @V_g+@V_o+@V_w
        @fgas  = @V_g/@V_t*100
        if (@fgas < 15.0 )
        @GHE = 'NO GS'
        elsif ( @fgas > 16.0 && @fgas < 30.0)
        @GHE = 'GS is required'
        else
        @GHE = 'AGH is required'
        end
        @check= @V_g*75.0/@V_t*100.0
        if( @GHE == 'GS is required' && @check < 15.0 )
        @ts = 'Static GS'
        elsif ( @check > 15.0 && @GHE == 'GS is required' )
        @ts= 'Dynamic GS'
        else
        @ts =''   
        end
        @SG_comp=(5.615*62.4*phaseoneparams[:GQ].to_f*((1-phaseoneparams[:WC].to_f/100.0)*phaseoneparams[:SG_o].to_f+phaseoneparams[:WC].to_f/100.0*phaseoneparams[:SG_w].to_f)+0.0752*phaseoneparams[:SG_g].to_f*phaseoneparams[:GQ].to_f*(1-phaseoneparams[:WC].to_f/100.0)*@GOR)/(5.615*62.4*phaseoneparams[:GQ].to_f)
        @H_L =(phaseoneparams[:VD_pump].to_f-(@PIP)/(phaseoneparams[:WGD].to_f*@SG_comp))
        @H_WHP =(phaseoneparams[:WHP].to_f-phaseoneparams[:CHP].to_f)/(phaseoneparams[:WGD].to_f*@SG_comp)
        if (  phaseoneparams[:TBG_ND].to_f == 119 )
            @TBG_ID=1.995
        elsif (  phaseoneparams[:TBG_ND].to_f == 120 )
            @TBG_ID=2.441
        elsif (  phaseoneparams[:TBG_ND].to_f == 121 )
            @TBG_ID=2.992
        elsif (  phaseoneparams[:TBG_ND].to_f == 122 )
            @TBG_ID=3.958
        end
        @F_t =15.11*(@V_t/120)**1.852/(@TBG_ID**4.8655)
        @H_f =@F_t*phaseoneparams[:VD_pump].to_f/1000
        @TDH =@H_L+@H_WHP+@H_f
        if ( phaseoneparams[:CSG_ND].to_f >104 && phaseoneparams[:CSG_ND].to_f < 108 )
            @series='series400'
        elsif ( phaseoneparams[:CSG_ND].to_f >107 && phaseoneparams[:CSG_ND].to_f < 114 &&  phaseoneparams[:GQ].to_f > 800 )
            @series='series513'
        elsif ( phaseoneparams[:CSG_ND].to_f >107 && phaseoneparams[:CSG_ND].to_f < 114 &&  phaseoneparams[:GQ].to_f < 800 )
            @series='series400'
        elsif ( phaseoneparams[:CSG_ND].to_f >114 && phaseoneparams[:CSG_ND].to_f < 119  && phaseoneparams[:GQ].to_f > 4500 )
            @series='series675'
        elsif ( phaseoneparams[:CSG_ND].to_f >114 && phaseoneparams[:CSG_ND].to_f < 119  && phaseoneparams[:GQ].to_f < 4500  && phaseoneparams[:GQ].to_f > 800 )
            @series='series513'
        elsif ( phaseoneparams[:CSG_ND].to_f >114 && phaseoneparams[:CSG_ND].to_f < 119   && phaseoneparams[:GQ].to_f < 800 )
            @series='series400'
        end
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
        @Hst=@V_t**5*@HC1+@V_t**4*@HC2+@V_t**3*@HC3+@V_t**2*@HC4+@V_t**1*@HC5+@HC6
        @HPst=@V_t**5*@HPC1+@V_t**4*@HPC2+@V_t**3*@HPC3+@V_t**2*@HPC4+@V_t**1*@HPC5+@HPC6
        @No_st=(@TDH/@Hst).ceil(0) 
        @ESP_Eff=(@V_t*@Hst)/(@HPst*1360)
        @data=TableService.new(Tablegenerate.new('HouseTable').get_table,{No_st:@No_st,type:@type}).final
        @SH_st=@data[:stages] 
        @HN=@data[:housing]
        @espp=@data[:cost]
        @HP_ESP=@SH_st*@HPst*@SG_comp
        @HP_seal=@HP_ESP*5/100
        if ( @GHE == 'AGH is required' )
        @HP_AGH=0.1*@HP_ESP
        else
        @HP_AGH=0.0
        end
        @HP_ESPm=@HP_ESP+@HP_seal+@HP_AGH
        @data2=TableService.new(Tablegenerate.new('ESPMotorSpecification').get_table,{HP_ESPm: @HP_ESPm,series:@series}).final
        @HP_ESPsm=@data2[:hp]
        @V_ESPsm=@data2[:Voltage]
        @I_ESPsm=@data2[:Amperage]
        @espmp=@data2[:Price]
        @x1=phaseoneparams[:T_bh].to_f
        @x2=phaseoneparams[:Q_g].to_f*1000/phaseoneparams[:GQ].to_f
        if (phaseoneparams[:CP].to_f == 49)
            @x3='Moderate'
        elsif ( phaseoneparams[:CP].to_f == 47 || phaseoneparams[:CP].to_f == 48) 
            @x3='Weak'
        elsif ( phaseoneparams[:CP].to_f == 50) 
            @x3='Excellent'
        end
        @data3=TableService.new(Tablegenerate.new('ElectricalCable').get_table,{maxTemp:@x1,gasResistanceIndex:@x2,CorrosionResistance:@x3}).final
        @ML=@HP_ESPm/@HP_ESPsm
        @PCT=@data3[:model]
        @a_c6=@data3[:a6]
        @a_c4=@data3[:a4]
        @a_c2=@data3[:a2]
        @a_c1=@data3[:a1]
        @Price1=@data3[:price1]
        @Price2=@data3[:price2]
        @Price4=@data3[:price4]
        @Price6=@data3[:price6]
        @T_c6=@a_c6*@I_ESPsm**2+phaseoneparams[:T_bh].to_f
        @T_c4=@a_c4*@I_ESPsm**2+phaseoneparams[:T_bh].to_f
        @T_c2=@a_c2*@I_ESPsm**2+phaseoneparams[:T_bh].to_f
        @T_c1=@a_c1*@I_ESPsm**2+phaseoneparams[:T_bh].to_f
        @dV6=(2.0/3.0)*@I_ESPsm*(1+0.00214*(@T_c6-77))
        @dV4=(5.0/11.0)*@I_ESPsm*(1+0.00214*(@T_c4-77))
        @dV2=(3.0/11.0)*@I_ESPsm*(1+0.00214*(@T_c2-77))
        @dV1=(3.0/14.0)*@I_ESPsm*(1+0.00214*(@T_c1-77))
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
        @CL=phaseoneparams[:MD_pump].to_f+@L_sl
        @V_surf=@V_ESPsm+@max*(phaseoneparams[:MD_pump].to_f/1000.0)
        @kVA_surf=1.732*@V_surf*@I_ESPsm*1.1/1000
        @data5=TableService.new(Tablegenerate.new('JunctionBoxselectionTable').get_table,@V_surf).final
        @sjb=@data5[:kv]
        @Junctioncost=@data5[:Junctioncost]
        @data4=TableService.new(Tablegenerate.new('SwitchboardTable').get_table,@kVA_surf).final
        @ssw=@data4[:ssw]
        @switchprice=@data4[:switchprice]
        @kVA_SB=@data4[:kva]
        @data6=TableService.new(Tablegenerate.new('TransformerTable').get_table,@kVA_surf).final
        @kVA_t=@data6[:kvce]
        @trp=@data6[:price]
        @EC_esp=1.73*phaseoneparams[:V_ml].to_f*@I_ESPsm*0.89*365*24*phaseoneparams[:EC].to_f/1000.0
        
        {
            sg_m: @sg_m,
              BHP: @BHP,
              PIP: @PIP,
              V_o: @V_o,
              V_w: @V_w,
              GOR: @GOR,
              Q_gt: @Q_gt,
              Q_gs: @Q_gs,
              Q_gf: @Q_gf,
              V_g: @V_g,
              V_t: @V_t,
              fgas: @fgas,
              GHE: @GHE,
              ts: @ts,
              SG_comp: @SG_comp,
              H_L: @H_L,
              H_WHP: @H_WHP,
              TBG_ID: @TBG_ID,
              F_t: @F_t,
              H_f: @H_f,
              TDH: @TDH,
              series: @series,
              type: @type,
              HC1: @HC1,
            HC2: @HC2,
            HC3: @HC3,
            HC4: @HC4,
            HC5: @HC5,
            HC6: @HC6,
            HPC1: @HPC1,
            HPC2: @HPC2,
            HPC3: @HPC3,
            HPC4: @HPC4,
            HPC5: @HPC5,
            HPC6: @HPC6,
            Hst: @Hst,
            HPst: @HPst,
            No_st: @No_st,
            ESP_Eff: @ESP_Eff,
            SH_st: @SH_st,
            HN: @HN,
            HP_ESP: @HP_ESP,
            HP_seal: @HP_seal,
            HP_AGH: @HP_AGH,
            HP_ESPm: @HP_ESPm,
            HP_ESPsm: @HP_ESPsm,
            V_ESPsm: @V_ESPsm,
            I_ESPsm: @I_ESPsm,
            ML: @ML,
            PCT: @PCT,
            a_c6: @a_c6,
            a_c4: @a_c4,
            a_c2: @a_c2,
            a_c1: @a_c1,
            T_c6: @T_c6,
            T_c4: @T_c4,
            T_c2: @T_c2,
            T_c1:@T_c1,
            dV6: @dV6,
            dV4:@dV4,
            dV2:@dV2,
            dV1:@dV1,
            SC:@SC,
            CL:@CL,
            V_surf:@V_surf,
            kVA_surf:@kVA_surf,
            sjb:@sjb,
            ssw:@ssw, 
            kVA_SB:@kVA_SB,
            kVA_t:@kVA_t,
            EC_esp:@EC_esp,
            espp:@espp,
            espmp:@espmp,
            price1:@Price1,
            price2:@Price2,
            price4:@Price4,
            price6:@Price6,
            switchprice:@switchprice,
            Junctioncost:@Junctioncost,
            trp:@trp
        }


        end
        
    end
end