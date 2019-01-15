require "#{Rails.root}/lib/phasetwo/table_generate.rb"
module PhaseTwoPumpOne
    class << self


        def pumpone (params,phaseoneparams)
            @SR_ND=phaseoneparams[:SR_ND].to_f
            @SR_ND = TableService.new(Tablegenerate.new('MatchTable').get_table,@SR_ND).final
            @SR_ND=@SR_ND.to_f
            if @SR_ND == 66
            @SR1_ND=6.0/8.0
            elsif  @SR_ND == 76 ||  @SR_ND == 77
            @SR1_ND=0.875  
            elsif @SR_ND == 86 ||  @SR_ND == 87 || @SR_ND == 88
            @SR1_ND=1.0        
            else
            @SR1_ND=1.125   
            end 
            @RT=phaseoneparams[:RT] #mina
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
            @se_rrp = TableService.new(Tablegenerate.new('AdditionalCriteriumTable').get_table,50).final
            @m_eff=params[:m_eff].to_f
            @MD_pump=phaseoneparams[:MD_pump].to_f
            if @MD_pump < 3000
            @L_p= 3
            elsif (((@MD_pump-3000)/1000.0)+3 < 6)
            @L_p=(((@MD_pump-3000)/1000.0)+3 ).ceil
            else
            @L_p= 6 
            end
            if @MD_pump < 4000
            @L_spacing =24
            else 
            @L_spacing =24 + 6*(@MD_pump/1000.0).ceil
            end
            @L_b=(@SL+(@L_p*12)+@L_spacing)/12
            @L_bs = TableService.new(Tablegenerate.new('BarrelSizesTable').get_table,@L_b).final
            @Delta=@SL*(@N_SRP**2)/70500
            @W_r=@SW_r*phaseoneparams[:VD_pump].to_f
            @sg_m=(phaseoneparams[:WC].to_f/100.0)*phaseoneparams[:SG_w].to_f+(1-(phaseoneparams[:WC].to_f/100.0))*phaseoneparams[:SG_o].to_f
            @Fo=phaseoneparams[:WGD].to_f*phaseoneparams[:VD_pump].to_f*(Math::PI/4*@ID_p**2)*@sg_m #(pi()/4*ID_p^2)*SG_m  =C28*C20*(PI()/4*H11^2)*C61
            @PPRL=@Fo+@W_r*(1+@Delta)
            @S_axial=@PPRL/(Math::PI/(4*@SR1_ND**2))
            @MPRL=@W_r*(1-0.128*@sg_m-@Delta)
            @PT=@SL/4*(@PPRL-@MPRL)
            @data = TableService.new(Tablegenerate.new('AvailablePumpingUnitTable').get_table,{PT: @PT,PPRL: @PPRL}).final
            @PPRL100=@data[:PPRL100]
            @PT1000=@data[:PT1000]
            @SL=@data[:SL]
            @HHP_srp=phaseoneparams[:GQ].to_f*phaseoneparams[:VD_pump].to_f/56000
            @FHP_srp=0.000000631*@W_r*@SL*@N_SRP
            @MHP_srp=(@HHP_srp+@FHP_srp).to_f/(@se_rrp*@m_eff).to_f
            @MHP_srps = TableService.new(Tablegenerate.new('NemaTable').get_table,@MHP_srp).final
            @EC_srp=0.746*@MHP_srp*24*365*phaseoneparams[:EC].to_f
            {
                Delta:@Delta,
                W_r:@w_r,
                sg_m:@sg_m,
                Fo:@Fo,
                PPRL:@PPRL,
                S_axial:@S_axial,
                MPRL: @MPRL,
                PT:@PT,
                data:@data,
                PPRL100:@PPRL100,
                PT1000:@PT1000,
                SL:@SL,
                HHP_srp:@HHP_srp,
                FHP_srp:@FHP_srp,
                MHP_srp:@MHP_srp,
                MHP_srps:@MHP_srps,
                EC_srp:@EC_srp,
                SR_ND:@SR_ND,
                SR1_ND:@SR1_ND,
                RT:@RT,
                YS_min:@YS_min,
                SL:@SL,
                N_SRP:@N_SRP,
                ID_SRP:@ID_SRP,
                ID_p:@ID_p,
                R1:@R1,
                R2:@R2,
                R3:@R3,
                R4:@R4,
                SW_r:@SW_r,
                se_rrp:@se_rrp,
                m_eff:@m_eff,
                MD_pump:@MD_pump,
                L_p:@L_p,
                L_bs:@L_bs,
                array:@array
            }
        end
        
    end
end
