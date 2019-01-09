require "#{Rails.root}/lib/phasetwo/table_generate.rb"
module PhaseTwoPumpOne
    class << self


        def pumpone (params,phaseoneparams)
            @SR_ND=params[:SR_ND].to_f
            if @SR_ND == 66
            @SR1_ND=6.0/8.0
            elsif  @SR_ND == 76 ||  @SR_ND == 77
            @SR1_ND=0.875  
            elsif @SR_ND == 86 ||  @SR_ND == 87 || @SR_ND == 88
            @SR1_ND=1.0        
            else
            @SR1_ND=1.125   
            end 
            @RT=params[:RT] #mina
            data = TableService.new(Tablegenerate.new('SuckerRodTable').get_table,@RT).final
            @YS_min=data[0]['yield_strength']
            @SL=params[:SL].to_f
            @N_SRP=params[:N_SRP].to_f
            @ID_SRP=Math.sqrt(phaseoneparams[:GQ].to_f/(0.1166*@SL*@N_SRP))
            @ID_p = TableService.new(Tablegenerate.new('AvailableSuckerRodPumpSize').get_table,@ID_SRP).final
            @array=TableService.new(Tablegenerate.new('RodStringTaperingPercentagesTable').get_table,{ID_p: @ID_p,SR_ND: @SR_ND,pump: 2}).final
            @R1= @array[0]['size_118'] 
            @R2=@array[0]['size_1']  
            @R3=@array[0]['size_78'] 
            @R4=@array[0]['size_34']  
            @SW_r=@array[0]['Rod_Weight']
            @SE_rrp=params[:SE_rrp].to_f  #mina admin
            @m_eff=params[:m_eff].to_f  #mina admin 
            # @L_p=5 #mina
            # @L_spacing=54 #mina
            # @L_b=(@SL+(@L_p*12)+@L_spacing)/12
            # @L_bs = TableService.new(Tablegenerate.new('BarrelSizesTable').get_table,@L_b).final
            # @Delta=@SL*(@N_SRP**2)/70500
            # @W_r=@SW_r*phaseoneparams[:VD_pump].to_f
            # @Fo=phaseoneparams[:WGD].to_f*phaseoneparams[:VD_pump].to_f*(Math::PI/4*@ID_p**2)*phaseoneparams[:SG_m].to_f #(pi()/4*ID_p^2)*SG_m  =C28*C20*(PI()/4*H11^2)*C61
            # @PPRL=@Fo+@W_r*(1+@Delta)
            # @S_axial=@PPRL/(Math::PI/(4*@SR1_ND**2))
            # @MPRL=@W_r*(1-0.128**phaseoneparams[:SG_m].to_f-@Delta)
            # @PT=@SL/4*(@PPRL-@MPRL)
            # @data = TableService.new(Tablegenerate.new('AvailablePumpingUnitTable').get_table,{PT: @PT,PPRL: @PPRL}).final
            # @PPRL100=@data[:PPRL100]
            # @PT1000=@data[:PT1000]
            # @SL=@data[:SL]
            # @HHP_srp=phaseoneparams[:GQ].to_f*phaseoneparams[:VD_pump].to_f/56000
            # @FHP_srp=0.000000631*@W_r*@SL*@N_SRP
            # @MHP_srp=(@HHP_srp+@FHP_srp)/(@PEff_srp*@MEff_srp)
            # @L_bs = TableService.new(Tablegenerate.new('NemaTable').get_table,@MHP_srp).final
            # @EC_srp=0.746*@MHP_srp*24*365*phaseoneparams[:EC].to_f
            @array
        end
        
    end
end
