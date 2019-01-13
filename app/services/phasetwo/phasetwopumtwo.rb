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
        @TBG_ID=2.441 #mina gat menen
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
        @No_st=(@TDH/@Hst).ceil(0) # mina 3ayza tet2ara bas
        # @ESP_Eff=(@V_t*@Hst)/(@HPst*1360)
        # @data=TableService.new(Tablegenerate.new('HouseTable').get_table,{No_st:@No_st,type:@type}).final
        # @SH_st=@data[:No_st] 
        # @HN=@data[:housing]
        # @HP_ESP=@SH_st*@HPst*@SG_comp
        # @HP_seal=@HP_ESP*5/100
        # @HP_AGH=0 #mina eih ba2a el mo3adla 
        # @HP_ESPm=@HP_ESP+@HP_seal+@HP_AGH
        # @data2=TableService.new(Tablegenerate.new('ESPMotorSpecification').get_table,{HP_ESPm: @HP_ESPm,series:@series}).final
        # @HP_ESPsm=@data2[:hp]
        # @V_ESPsm=@data2[:Voltage]
        # @I_ESPsm=@data2[:Amperage]
        # @x1=86 #eih dol 2slan :D
        # @x2=769.231 #eih dol 2slan :D
        # @x3='Moderate' #eih dol 2slan :D
        # @data3=TableService.new(Tablegenerate.new('ElectricalCable').get_table,{maxTemp:@x1,gasResistanceIndex:@x2,CorrosionResistance:@x3}).final
        # @ML=@HP_ESPm/@HP_ESPsm
        # @PCT=@data3[:model]
        # @a_c6=@data3[:a6]
        # @a_c4=@data3[:a4]
        # @a_c2=@data3[:a2]
        # @a_c1=@data3[:a1]
        # @T_c6=@a_c6*@I_ESPsm**2+phaseoneparams[:T_bh].to_f
        # @T_c4=@a_c4*@I_ESPsm**2+phaseoneparams[:T_bh].to_f
        # @T_c2=@a_c2*@I_ESPsm**2+phaseoneparams[:T_bh].to_f
        # @T_c1=@a_c1*@I_ESPsm**2+phaseoneparams[:T_bh].to_f
        # @dV6=(2.0/3.0)*@I_ESPsm*(1+0.00214*(@T_c6-77))
        # @dV4=(5.0/11.0)*@I_ESPsm*(1+0.00214*(@T_c6-77))
        # @dV2=(3.0/11.0)*@I_ESPsm*(1+0.00214*(@T_c6-77))
        # @dV1=(3.0/14.0)*@I_ESPsm*(1+0.00214*(@T_c6-77))
        # @L_sl=params[:L_sl].to_f
        # @CL=phaseoneparams[:MD_pump].to_f+@L_sl
        # @V_surf=531.602 #mina eih ba2a el mmo3adla  (in this case)
        # @kVA_surf=1.732*@V_surf*@I_ESPsm*1.1/1000
        # @sjb=TableService.new(Tablegenerate.new('JunctionBoxselectionTable').get_table,@V_surf).final
        # @ssb='2C-CG' #mina fen el gadwal
        # # @kVA_SB #mina 
        # @kVA_SB=37 #mina
        # @kVA_t=75 #mina
        # @EC_esp=9873.049 #mina
        
        {

            array:@array,
            series:@series,
            Hst:@Hst,
            HPst:@HPst,
            No_st:@No_st
            
        }

        end
        
    end
end