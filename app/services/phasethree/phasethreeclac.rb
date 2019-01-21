require "#{Rails.root}/lib/phasetwo/table_generate.rb"
module PhaseThreeCalc
    class << self
        def phasethreecalc (params,phaseoneparams)
           @sic = phaseoneparams[:RIT].to_f*params[:spr]
           @nsr= ((phaseoneparams[:PAP].to_f - 1.0)/ phaseoneparams[:SMTTF].to_f).floor
           if (@nsr > 0 )
                @nsr1=(phaseoneparams[:SMTTF].to_f - 1.0 )/phaseoneparams[:SMTBF].to_f
           else 
            @nsr1=(phaseoneparams[:PAP].to_f - 1.0 )/phaseoneparams[:SMTBF].to_f
           end
           @nsr1=@nsr1.floor
           if (@nsr > 0 )
               if( (phaseoneparams[:PAP].to_f - phaseoneparams[:SMTTF].to_f) > 0 )
                    @nsr2=((phaseoneparams[:SMTTF].to_f - 1.0 )/phaseoneparams[:SMTBF].to_f).floor
                else
                    @nsr2=((phaseoneparams[:PAP].to_f -  phaseoneparams[:SMTTF].to_f - 1.0 )/phaseoneparams[:SMTBF].to_f).floor
               end
           elsif
            @nsr2=0.0 
           end

           if (@nsr > 1 )
            if( (phaseoneparams[:PAP].to_f - phaseoneparams[:SMTTF].to_f*2) > phaseoneparams[:SMTTF].to_f )
                 @nsr3=((phaseoneparams[:SMTTF].to_f - 1.0 )/phaseoneparams[:SMTBF].to_f).floor
             else
                 @nsr3=((phaseoneparams[:PAP].to_f -  phaseoneparams[:SMTTF].to_f*2 - 1.0 )/phaseoneparams[:SMTBF].to_f).floor
            end
        elsif
         @nsr3=0.0 
        end


        if (@nsr > 2 )
            if( (phaseoneparams[:PAP].to_f - phaseoneparams[:SMTTF].to_f*3) > phaseoneparams[:SMTTF].to_f )
                 @nsr4=((phaseoneparams[:SMTTF].to_f - 1.0 )/phaseoneparams[:SMTBF].to_f).floor
             else
                 @nsr4=((phaseoneparams[:PAP].to_f -  phaseoneparams[:SMTTF].to_f*3 - 1.0 )/phaseoneparams[:SMTBF].to_f).floor
            end
        elsif
         @nsr4=0.0 
        end
        if (@nsr > 3 )
            if( (phaseoneparams[:PAP].to_f - phaseoneparams[:SMTTF].to_f*4) > phaseoneparams[:SMTTF].to_f )
                 @nsr5=((phaseoneparams[:SMTTF].to_f - 1.0 )/phaseoneparams[:SMTBF].to_f).floor
             else
                 @nsr5=((phaseoneparams[:PAP].to_f -  phaseoneparams[:SMTTF].to_f*4 - 1.0 )/phaseoneparams[:SMTBF].to_f).floor
            end
        elsif
         @nsr5=0.0
        end

        @ndr= ((phaseoneparams[:PAP].to_f - 1.0)/ phaseoneparams[:DMTTF].to_f).floor
           if (@ndr > 0 )
                @ndr1=(phaseoneparams[:DMTTF].to_f - 1.0 )/phaseoneparams[:DMTBF].to_f
           else 
            @ndr1=(phaseoneparams[:PAP].to_f - 1.0 )/phaseoneparams[:DMTBF].to_f
           end
           @ndr1=@ndr1.floor
           if (@ndr > 0 )
               if( (phaseoneparams[:PAP].to_f - phaseoneparams[:DMTTF].to_f) > 0 )
                    @ndr2=((phaseoneparams[:DMTTF].to_f - 1.0 )/phaseoneparams[:DMTBF].to_f).floor
                else
                    @ndr2=((phaseoneparams[:PAP].to_f -  phaseoneparams[:DMTTF].to_f - 1.0 )/phaseoneparams[:DMTBF].to_f).floor
               end
           elsif
            @ndr2=0.0
           end

           if (@ndr > 1 )
            if( (phaseoneparams[:PAP].to_f - (phaseoneparams[:DMTTF].to_f*2.0)) > phaseoneparams[:DMTTF].to_f )
                 @ndr3=((phaseoneparams[:DMTTF].to_f - 1.0 )/phaseoneparams[:DMTBF].to_f).floor
             else
                 @ndr3=((phaseoneparams[:PAP].to_f - ( phaseoneparams[:DMTTF].to_f*2.0) - 1.0 )/phaseoneparams[:DMTBF].to_f).floor
            end
        elsif
         @ndr3=0.0
        end


        if (@ndr > 2 )
            if( (phaseoneparams[:PAP].to_f - phaseoneparams[:DMTTF].to_f*3) > phaseoneparams[:DMTTF].to_f )
                 @ndr4=((phaseoneparams[:DMTTF].to_f - 1.0 )/phaseoneparams[:DMTBF].to_f).floor
             else
                 @ndr4=((phaseoneparams[:PAP].to_f -  phaseoneparams[:DMTTF].to_f*3 - 1.0 )/phaseoneparams[:DMTBF].to_f).floor
            end
        elsif
         @ndr4=0.0
        end
        if (@ndr > 3 )
            if( (phaseoneparams[:PAP].to_f - phaseoneparams[:DMTTF].to_f*4) > phaseoneparams[:DMTTF].to_f )
                 @ndr5=((phaseoneparams[:DMTTF].to_f - 1.0 )/phaseoneparams[:DMTBF].to_f).floor
             else
                 @ndr5=((phaseoneparams[:PAP].to_f -  phaseoneparams[:DMTTF].to_f*4 - 1.0 )/phaseoneparams[:DMTBF].to_f).floor
            end
        elsif
         @ndr5=0.0
        end

        if (@ndr > 4 )
            if( (phaseoneparams[:PAP].to_f - phaseoneparams[:DMTTF].to_f*5) > phaseoneparams[:DMTTF].to_f )
                 @ndr6=((phaseoneparams[:DMTTF].to_f - 1.0 )/phaseoneparams[:DMTBF].to_f).floor
             else
                 @ndr6=((phaseoneparams[:PAP].to_f -  phaseoneparams[:DMTTF].to_f*5 - 1.0 )/phaseoneparams[:DMTBF].to_f).floor
            end
        elsif
         @ndr6=0.0
        end
        if (@ndr6 == '' || @ndr6== 0.0)
        @error2='This system is not preferable for this well because of more than 5 times downhole equipment  replacement'
        end
        @snrt=(@nsr+@nsr1+@nsr2+@nsr3+@nsr4+@nsr5)
        @ndrt=(@ndr+@ndr1+@ndr2+@ndr3+@ndr4+@ndr5)

        @mrc=@ndr*params[:trdc]+@nsr*params[:trsc]+@ndrt*(params[:scc]+params[:spr])+@snrt*params[:scc]
        @papd=params[:papd]
        @ecry=params[:ecry]
        if( @nsr == 0  )
            @sse=params[:trsc]*(1.0 - phaseoneparams[:SSR].to_f )**@papd
        elsif ( @nsr == 1 )
            @sse=params[:trsc]*(1.0 - phaseoneparams[:SSR].to_f )**((phaseoneparams[:PAP].to_f - phaseoneparams[:SMTTF].to_f)/365.0)
        elsif ( @nsr == 2)
            @sse=params[:trsc]*(1.0 - phaseoneparams[:SSR].to_f )**((phaseoneparams[:PAP].to_f - phaseoneparams[:SMTTF].to_f*2)/365.0)
        elsif ( @nsr == 3 )
            @sse=params[:trsc]*(1.0 - phaseoneparams[:SSR].to_f )**((phaseoneparams[:PAP].to_f - phaseoneparams[:SMTTF].to_f*3)/365.0)
        elsif ( @nsr == 4 )
            @sse=params[:trsc]*(1.0 - phaseoneparams[:SSR].to_f )**((phaseoneparams[:PAP].to_f - phaseoneparams[:SMTTF].to_f*4)/365.0)
        else
            @sse=params[:trsc]*(1.0 - phaseoneparams[:SSR].to_f )**((phaseoneparams[:PAP].to_f - phaseoneparams[:SMTTF].to_f*5)/365.0)
        end

        if( @ndr == 0  )
            @dse=params[:trdc]*(1.0 - phaseoneparams[:DSR].to_f )**@papd
        elsif ( @ndr == 1 )
            @dse=params[:trdc]*(1.0 - phaseoneparams[:DSR].to_f )**((phaseoneparams[:PAP].to_f - phaseoneparams[:DMTTF].to_f)/365.0)
        elsif ( @ndr == 2)
            @dse=params[:trdc]*(1.0 - phaseoneparams[:DSR].to_f )**((phaseoneparams[:PAP].to_f - phaseoneparams[:DMTTF].to_f*2)/365.0)
        elsif ( @ndr == 3 )
            @dse=params[:trdc]*(1.0 - phaseoneparams[:DSR].to_f )**((phaseoneparams[:PAP].to_f - phaseoneparams[:DMTTF].to_f*3)/365.0)
        elsif ( @ndr == 4 )
            @dse=params[:trdc]*(1.0 - phaseoneparams[:DSR].to_f )**((phaseoneparams[:PAP].to_f - phaseoneparams[:DMTTF].to_f*4)/365.0)
        else
            @dse=params[:trdc]*(1.0 - phaseoneparams[:DSR].to_f )**((phaseoneparams[:PAP].to_f - phaseoneparams[:DMTTF].to_f*5)/365.0)
        end
        @pdt=(@nsr+@nsr1+@nsr2+@nsr3+@nsr4+@nsr5)*phaseoneparams[:SDT].to_f+(@ndr+@ndr1+@ndr2+@ndr3+@ndr4+@ndr5)*phaseoneparams[:DDT].to_f
        @tem=@mrc/5.0
        @summ=@tem
        for i in 0..(@papd -2.0)
            @tem=@tem*(1.0+phaseoneparams[:MIR].to_f)
            @summ=@summ+@tem
         end
        @summ= @summ/5.0
        
        @tem=@ecry/@papd
        @sumo=@tem
        for i in 0..(@papd -2.0)
            @tem=@tem*(1.0+phaseoneparams[:OIR].to_f)
            @sumo=@sumo+@tem
         end
        @sumo= @sumo/5.0
        @opt=phaseoneparams[:OP].to_f*(365.0-@pdt/5.0)*phaseoneparams[:GQ].to_f
        
        @tem=@opt
        @sumop=@tem
        for i in 0..(@papd -2.0)
            @tem=@tem*(1.0+phaseoneparams[:OPIR].to_f)
            @sumop=@sumop+@tem
            
         end
        @sumop= (@sumop + @sse + @dse)

        @ncf=@sumop/5.0-@sumo-@summ-@sumop-params[:capr]
        # @mpp=@sumop/@papd-@cuo*(1-phaseoneparams[:DR].to_f)**@papd
        {
            pdt:@pdt,
            nsr:@nsr,
            nsr1:@nsr1,
            nsr2:@nsr2,
            nsr3:@nsr3,
            nsr4:@nsr4,
            nsr5:@nsr5,
            ndr:@ndr,
            ndr1:@ndr1,
            ndr2:@ndr2,
            ndr3:@ndr3,
            ndr4:@ndr4,
            ndr5:@ndr5,
            mrc:@mrc,
            ecry:@ecry,
            papd:@papd,
            sse:@sse,
            dse:@dse,
            summ:@summ,
            sumo:@sumo,
            sumop:@sumop,
            opt:@opt,
                }
        end
            
    end
end