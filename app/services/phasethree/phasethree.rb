require "#{Rails.root}/lib/phasetwo/table_generate.rb"
module PhaseThree
    class << self
        def phasethreepump1 (params,phaseoneparams)
            @R1result=@R2result=@R3result=@R4result=0.0
            if(!params[:R1].nil?)
            @R1result=params[:R1]*phaseoneparams[:MD_pump].to_f/100.0
            end
            if(!params[:R2].nil?)
            @R2result=params[:R2]*phaseoneparams[:MD_pump].to_f/100.0
            end
            if(!params[:R3].nil?)
            @R3result=params[:R3]*phaseoneparams[:MD_pump].to_f/100.0
            end
            if(!params[:R4].nil?)
            @R4result=params[:R4]*phaseoneparams[:MD_pump].to_f/100.0
            end
            @no6=(@R4result/25.0).round 
            @no7=(@R3result/25.0).round 
            @no8=(@R2result/25.0).round 
            @no9=(@R1result/25.0).round 
            @RT=phaseoneparams[:RT].to_f
            @RT = TableService.new(Tablegenerate.new('MatchTable').get_table,@RT).final
            @data = TableService.new(Tablegenerate.new('RodStringPriceTable').get_table,@RT).final
            @pn6=@data[:pn6]
            @pn7=@data[:pn7]
            @pn8=@data[:pn8]
            @pn9=@data[:pn9]
            @c6=@no6*@pn6
            @c7=@no7*@pn7
            @c8=@no8*@pn8
            @c9=@no9*@pn9
            @ctot=@c6+@c7+@c8+@c9
            @rrpt=params[:rrpt]
            @ID_p=params[:ID_p]
            if( phaseoneparams[:CP].to_f == 47 || phaseoneparams[:CP].to_f == 48)
                @corrosivity=0
            else
                @corrosivity=1
            end
            @prprice= TableService.new(Tablegenerate.new('SrppriceTable').get_table,{ID_p:@ID_p ,rrpt:@rrpt ,corrosivity:@corrosivity }).final
             if ( params[:L_p] == 4  )
                @prprice=@prprice*1.00
             elsif ( params[:L_p] == 5  )
                @prprice=@prprice*1.005
             else 
                @prprice=@prprice*1.01
             end

            if( params[:L_bs] == 12)
                @prprice=@prprice
            elsif( params[:L_bs] == 16)
                @prprice=@prprice*1.2
            elsif( params[:L_bs] == 20)
                @prprice=@prprice*1.5
            else
                @prprice=@prprice*1.8
            end

            @trsc=(params[:spuc]+params[:mcost])*1.1
            @trdc=(@ctot+@prprice)*1.1
            @capr=@trsc+@trdc
            @AST=phaseoneparams[:AST].to_f
            @AST = TableService.new(Tablegenerate.new('MatchTable').get_table,@AST).final
            @WL=phaseoneparams[:WL].to_f
            @WL = TableService.new(Tablegenerate.new('MatchTable').get_table,@WL).final
            if ( (@WL  == 'Onshore' || @WL == 'Urban' ) && (@AST == 'Pulling Unit' ||  @AST == 'Both') && params[:rrpt]  == 'Rod Pump')
                @spr = TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'Pulling Unit').final
            elsif ( (@WL  == 'Onshore' || @WL == 'Urban' ) && (@AST == 'W/O Rig' ||  @AST == 'Both')  )
                @spr = TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'Onshore W/O rig').final
            elsif ( @WL  == 'Offshore'  && @AST == 'W/O Rig' )
                @spr = TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'Offshore W/O rig').final
            else 
                @error ='W/O rig is a must'
            end
            @scc =  TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'RRP Crew Daily Rate').final
            @ic=(@scc+@spr)*phaseoneparams[:RIT].to_f
            @papd=(phaseoneparams[:PAP].to_f/365.0).floor
            @ecry=@papd*params[:EC_srp]
            pumpone = {
                R1result: @R1result,
                R2result: @R2result,
                R3result: @R3result,
                R4result: @R4result,
                no6:@no6,
                no7:@no7,
                np8:@no8,
                no9:@no9,
                pn6:@pn6,
                pn7:@pn7,
                pn8:@pn8,
                pn9:@pn8,
                c6:@c6,
                c7:@c7,
                c8:@c8,
                c9:@c9,
                ctot:@ctot,
                rrpt:@rrpt,
                prprice:@prprice,
                trsc:@trsc,
                capr:@capr,
                trdc:@trdc,
                spr:@spr,
                scc:@scc,
                ecry:@ecry,
                papd:@papd,
                ic:@ic
            }
            @finalpumpone = PhaseThreeCalc.phasethreecalc(pumpone , phaseoneparams )
            @finalpumpone=@finalpumpone.merge(pumpone) 
            @finalpumpone

        end

        def phasethreepump2 (params,phaseoneparams)
        if ( params[:GHE] == 'AGH is required' ||  params[:ts]= 'Dynamic GS')
        @esppg=1.1*params[:espp]
        else
        @esppg= params[:espp]
        end
        if( phaseoneparams[:CP].to_f == 47 || phaseoneparams[:CP].to_f == 48)
            @corrosivity=0
        else
            @corrosivity=1
        end
        if( @corrosivity == 0 )
            @esppg= params[:espp]
        else
            @esppg= params[:espp]*1.25  
        end
        if( @corrosivity == 0 )
            @espmp= params[:espmp]
        else
            @espmp= params[:espmp]*1.1
        end
        if (params[:SC] == '#6')
            @ecp =params[:price6]
        elsif  (params[:SC] == '#4')
            @ecp =params[:price4]
        elsif (params[:SC] == '#2')
            @ecp =params[:price2]
        elsif (params[:SC] == '#1')
            @ecp =params[:price]
        end
        @ecpt=@ecp*(params[:CL])
        @jbp=params[:Junctioncost]
        @sbp=params[:switchprice]
        @trp=params[:trp]
        @tesc=@jbp+@sbp+@trp
        @tedc=@esppg+@espmp+@ecpt
        @cape=(@tesc + @tedc)*1.1
        @AST=phaseoneparams[:AST].to_f
        @AST = TableService.new(Tablegenerate.new('MatchTable').get_table,@AST).final
        @WL=phaseoneparams[:WL].to_f
        @WL = TableService.new(Tablegenerate.new('MatchTable').get_table,@WL).final
        if ( (@WL  == 'Onshore' || @WL == 'Urban' ) && ( @AST == 'Both')  )
            @spr = TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'Onshore W/O rig').final
        elsif ( (@WL  == 'Onshore' || @WL == 'Urban' ) && (@AST == 'W/O Rig' ||  @AST == 'Both')  )
            @spr = TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'Onshore W/O rig').final
        elsif ( @WL  == 'Offshore'  && @AST == 'W/O Rig' )
            @spr = TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'Offshore W/O rig').final
        else 
            @error ='W/O rig is a must'
        end
        @scc =  TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'ESP Crew Daily Rate').final
        @papd=(phaseoneparams[:PAP].to_f/365.0).floor
        @ecry=@papd*params[:EC_esp]
        @ic=(@scc+@spr)*phaseoneparams[:RIT].to_f

        pumptwo={
            esppg:@esppg,
            espmp:@espmp,
            ecpt:@ecpt,
            jbp:@jbp,
            sbp:@sbp,
            trp:@trp,
            tesc:@tesc,
            tedc:@tedc,
            capr:@cape,
            spr:@spr,
            scc:@scc,
            trsc:@tesc,
            trdc:@tedc,
            papd:@papd,
            ecry:@ecry,
            wl:@WL,
            ic:@ic,
            AST:@AST
        }

        @finalpumptwo = PhaseThreeCalc.phasethreecalc(pumptwo , phaseoneparams )
        @finalpumptwo=@finalpumptwo.merge(pumptwo) 
        @finalpumptwo

        end

        def phasethreepump3 (params,phaseoneparams)
            @RT=phaseoneparams[:RT].to_f
            @RT = TableService.new(Tablegenerate.new('MatchTable').get_table,@RT).final
            @data = TableService.new(Tablegenerate.new('RodStringPriceTable').get_table,@RT).final
            if ( params[:PR_ND] == 77 )
                @prc=@data[:pn7]
            elsif ( params[:PR_ND] == 66 )
                @prc=@data[:pn6]
            elsif ( params[:PR_ND] == 88 )
                @prc=@data[:pn8]
            elsif ( params[:PR_ND] == 99 )
                @prc=@data[:pn]
            end

            @cpc=(phaseoneparams[:MD_pump].to_f/25.0)*@prc
            
            if( phaseoneparams[:CP].to_f == 47 || phaseoneparams[:CP].to_f == 48)
                @corrosivity=0
            else
                @corrosivity=1
            end
            if( @corrosivity == 0 )
                @ppp=params[:ppp]
            else
                @ppp= params[:ppp]*1.25  
            end
            @pafc=params[:pafc]
            @ppp=@ppp*@pafc
            @phc=params[:phc]
            @MHP_Ps=params[:MHP_Ps]
            @data = TableService.new(Tablegenerate.new('NemaTable').get_table,@MHP_Ps).final
            @pmc=@data[:mcost]
            @tpdc=@ppp+@cpc
            @tpsc=@pmc+@phc
            @capr=(@tpdc+@tpsc)*1.1
            @AST=phaseoneparams[:AST].to_f
            @AST = TableService.new(Tablegenerate.new('MatchTable').get_table,@AST).final
            @WL=phaseoneparams[:WL].to_f
            @WL = TableService.new(Tablegenerate.new('MatchTable').get_table,@WL).final
            if ( (@WL  == 'Onshore' || @WL == 'Urban' ) && ( @AST == 'Both')  )
                @spr = TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'Onshore W/O rig').final
            elsif ( (@WL  == 'Onshore' || @WL == 'Urban' ) && (@AST == 'W/O Rig' ||  @AST == 'Both')  )
                @spr = TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'Onshore W/O rig').final
            elsif ( @WL  == 'Offshore'  && @AST == 'W/O Rig' )
                @spr = TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'Offshore W/O rig').final
            else 
                @error ='W/O rig is a must'
            end
            @scc =  TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'PCP Crew Daily Rate').final
            @ic=(@scc+@spr)*phaseoneparams[:RIT].to_f
            @papd=(phaseoneparams[:PAP].to_f/365.0).floor
            @ecry=@papd*params[:EC_pcp]
            pumpthree= {
                prc:@prc,
                cpc:@cpc,
                ppp:@ppp,
                pafc:@pafc,
                pmc:@pmc,
                trdc:@tpdc,
                trsc:@tpsc,
                capr:@capr,
                AST:@AST,
                WL:@WL,
                spr:@spr,
                scc:@scc,
                ic:@ic,
                papd:@papd,
                ecry:@ecry
            }

            @finalpumpthree = PhaseThreeCalc.phasethreecalc(pumpthree , phaseoneparams )
            @finalpumpthree=@finalpumpthree.merge(pumpthree) 
            @finalpumpthree
        end


        def phasethreepump4 (params,phaseoneparams)
            if( phaseoneparams[:CP].to_f == 47 || phaseoneparams[:CP].to_f == 48)
                @corrosivity=0
            else
                @corrosivity=1
            end
            if( @corrosivity == 0 )
                @espp=params[:espp]
            else
                @espp=params[:espp]*1.15
            end
            @pafc=params[:pafc]
            @espp=@espp*@pafc
            if (params[:SC] == '#6')
                @ecp =params[:price6]
            elsif  (params[:SC] == '#4')
                @ecp =params[:price4]
            elsif (params[:SC] == '#2')
                @ecp =params[:price2]
            elsif (params[:SC] == '#1')
                @ecp =params[:price]
            end
            @ecpt=@ecp*(params[:CL])
            @pfsc=params[:pfsc]
            @trp=params[:trp]

            @tpdc=@espp+@ecpt
            @tpsc=@trp+@pfsc
            @capr=(@tpdc+@tpsc)*1.1
            @AST=phaseoneparams[:AST].to_f
            @AST = TableService.new(Tablegenerate.new('MatchTable').get_table,@AST).final
            @WL=phaseoneparams[:WL].to_f
            @WL = TableService.new(Tablegenerate.new('MatchTable').get_table,@WL).final
            if ( (@WL  == 'Onshore' || @WL == 'Urban' ) && ( @AST == 'Both')  )
                @spr = TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'Onshore W/O rig').final
            elsif ( (@WL  == 'Onshore' || @WL == 'Urban' ) && (@AST == 'W/O Rig' ||  @AST == 'Both')  )
                @spr = TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'Onshore W/O rig').final
            elsif ( @WL  == 'Offshore'  && @AST == 'W/O Rig' )
                @spr = TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'Offshore W/O rig').final
            else 
                @error ='W/O rig is a must'
            end
            @scc =  TableService.new(Tablegenerate.new('InstallationCrewTable').get_table,'ESPCP Crew Daily Rate').final
            @ic=(@scc+@spr)*phaseoneparams[:RIT].to_f
            @papd=(phaseoneparams[:PAP].to_f/365.0).floor
            @ecry=@papd*params[:EC_espcp]

          pumpfour=  {
                ecp:@ecp,
                pafc:@pafc,
                espp:@espp,
                ecpt:@ecpt,
                pfsc:@pfsc,
                trp:@trp,
                trdc:@tpdc,
                trsc:@tpsc,
                capr:@capr,
                spr:@spr,
                scc:@scc,
                ic:@ic,
                papd:@papd,
                ecry:@ecry
            }
            @finalpumpfour = PhaseThreeCalc.phasethreecalc(pumpfour , phaseoneparams )
            @finalpumpfour=@finalpumpfour.merge(pumpfour) 
            @finalpumpfour

        end
            
    end
end