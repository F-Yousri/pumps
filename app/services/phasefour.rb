module PhaseFour
    class << self
        def make (phaseoneresult,pump,resultphasthree ,params) 
            finalPumps = getonlyrightpump(phaseoneresult ,pump ) 
            cdcpumps = addcdc(finalPumps , resultphasthree)   
            # xiarray  = clacxi (cdcpumps)
            # newarray = newPumpArrayAfterdivXi(xiarray ,cdcpumps ,params)
        end


        def getonlyrightpump (phaseoneresult ,pump ) 
            finalphaseone =[];
            @phaseoneresult = phaseoneresult
            for i in 0..pump.length
                if (pump[i] == phaseoneresult[i][0] )
                    finalphaseone.push(phaseoneresult[i])
                end
             end
            finalphaseone
        end

        def addcdc finalPumps , resultphasthree
            finalPumps.map { |pump|
            if (pump[0] == 'RRP')
                pump[1]['cdc'] = resultphasthree['phasethreepump1'][:cdc]
            elsif (pump[0] == 'ESP')
                pump[1]['cdc'] = resultphasthree['phasethreepump2'][:cdc]
            elsif (pump[0] == 'PCP')
                pump[1]['cdc'] = resultphasthree['phasethreepump3'][:cdc]
            elsif (pump[0] == 'ESPCP')
                pump[1]['cdc'] = resultphasthree['phasethreepump4'][:cdc]
            end
            }
            finalPumps
        end

        def clacxi cdcpumps
            xiarray={}
            wl=md_pump=wd=csg_nd=ds=gq=j=t_bh=meo_m=api=ap=cp=arp=ep=sp=pp=glr=apm=ast=pf=pr=se=cdc=0
            cdcpumps.each{ |pump|  wl =wl +  pump[1]['WL'][0].to_f**2  }
            cdcpumps.each{ |pump|  md_pump =md_pump +  pump[1]['MD_pump'][0].to_f**2  }
            cdcpumps.each{ |pump|  wd =wd +  pump[1]['WD'][0].to_f**2  }
            cdcpumps.each{ |pump|  csg_nd =csg_nd +  pump[1]['CSG_ND'][0].to_f**2  }
            cdcpumps.each{ |pump|  ds =ds +  pump[1]['DS'][0].to_f**2  }
            cdcpumps.each{ |pump|  gq =gq +  pump[1]['GQ'][0].to_f**2  }
            cdcpumps.each{ |pump|  j =j +  pump[1]['J'][0].to_f**2  }
            cdcpumps.each{ |pump|  t_bh =t_bh +  pump[1]['T_bh'][0].to_f**2  }
            cdcpumps.each{ |pump|  meo_m =meo_m +  pump[1]['meo_m'][0].to_f**2  }
            cdcpumps.each{ |pump|  api =api +  pump[1]['API'][0].to_f**2  }
            cdcpumps.each{ |pump|  ap =ap +  pump[1]['AP'][0].to_f**2  }
            cdcpumps.each{ |pump|  cp =cp +  pump[1]['CP'][0].to_f**2  }
            cdcpumps.each{ |pump|  arp =arp +  pump[1]['ArP'][0].to_f**2  }
            cdcpumps.each{ |pump|  ep =ep +  pump[1]['EP'][0].to_f**2  }
            cdcpumps.each{ |pump|  sp =sp +  pump[1]['SP'][0].to_f**2  }
            cdcpumps.each{ |pump|  pp =pp +  pump[1]['PP'][0].to_f**2  }
            cdcpumps.each{ |pump|  glr =glr +  pump[1]['GLR'][0].to_f**2  }
            cdcpumps.each{ |pump|  apm =apm +  pump[1]['APM'][0].to_f**2  }
            cdcpumps.each{ |pump|  ast =ast +  pump[1]['AST'][0].to_f**2  }
            cdcpumps.each{ |pump|  pf =pf +  pump[1]['PF'][0].to_f**2  }
            cdcpumps.each{ |pump|  pr =pr +  pump[1]['PR'][0].to_f**2  }
            cdcpumps.each{ |pump|  se =se +  pump[1]['SE'][0].to_f**2  }
            cdcpumps.each{ |pump|  cdc =cdc +  pump[1]['cdc'].to_f**2  }
            xiarray[:wl] = Math.sqrt(wl)
            xiarray[:md_pump] = Math.sqrt(md_pump)
            xiarray[:wd] = Math.sqrt(wd)
            xiarray[:csg_nd] = Math.sqrt(csg_nd)
            xiarray[:ds] = Math.sqrt(ds)
            xiarray[:gq] = Math.sqrt(gq)
            xiarray[:j] = Math.sqrt(j)
            xiarray[:t_bh] = Math.sqrt(t_bh)
            xiarray[:meo_m] = Math.sqrt(meo_m)
            xiarray[:api] = Math.sqrt(api)
            xiarray[:ap] = Math.sqrt(ap)
            xiarray[:cp] = Math.sqrt(cp)
            xiarray[:arp] = Math.sqrt(arp)
            xiarray[:ep] = Math.sqrt(ep)
            xiarray[:sp] = Math.sqrt(sp)
            xiarray[:pp] = Math.sqrt(pp)
            xiarray[:glr] = Math.sqrt(glr)
            xiarray[:apm] = Math.sqrt(apm)
            xiarray[:ast] = Math.sqrt(ast)
            xiarray[:pf] = Math.sqrt(pf)
            xiarray[:pr] = Math.sqrt(pr)
            xiarray[:se] = Math.sqrt(se)
            xiarray[:cdc] = Math.sqrt(cdc)
            xiarray
        end

        def newPumpArrayAfterdivXi (xiarray ,cdcpumps ,params)
            newarray ={}
            cdcpumps.each{ |pump|  
            newarray[pump[0]]  ={}
            }
            cdcpumps.each{ |pump| newarray[pump[0]][:wl] =(pump[1]['WL'][0] / xiarray[:wl])*params[:W_WL].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:md_pump] =(pump[1]['MD_pump'][0] / xiarray[:md_pump])*params[:W_MD_pump].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:wd] =(pump[1]['WD'][0] / xiarray[:wd])*params[:W_WD].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:csg_nd] =(pump[1]['CSG_ND'][0] / xiarray[:csg_nd])*params[:W_CSG_ND].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:ds] =(pump[1]['DS'][0] / xiarray[:ds])*params[:W_DS].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:gq] =(pump[1]['GQ'][0] / xiarray[:gq])*params[:W_GQ].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:j] =(pump[1]['J'][0] / xiarray[:j])*params[:W_J].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:t_bh] =(pump[1]['T_bh'][0] / xiarray[:t_bh])*params[:W_T_bh].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:meo_m] =(pump[1]['meo_m'][0] / xiarray[:meo_m])*params[:W_meo_m].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:api] =(pump[1]['API'][0] / xiarray[:api])*params[:W_API].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:ap] =(pump[1]['AP'][0] / xiarray[:ap])*params[:W_AP].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:cp] =(pump[1]['CP'][0] / xiarray[:cp])*params[:W_CP].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:arp] =(pump[1]['ArP'][0] / xiarray[:arp])*params[:W_ArP].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:ap] =(pump[1]['AP'][0] / xiarray[:ap])*params[:W_AP].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:sp] =(pump[1]['SP'][0] / xiarray[:sp])*params[:W_SP].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:pp] =(pump[1]['PP'][0] / xiarray[:pp])*params[:W_PP].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:glr] =(pump[1]['GLP'][0] / xiarray[:glr])*params[:W_GLR].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:apm] =(pump[1]['APM'][0] / xiarray[:apm])*params[:W_APM].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:ste] =(pump[1]['STE'][0] / xiarray[:ste])*params[:W_STE].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:ast] =(pump[1]['AST'][0] / xiarray[:ast])*params[:W_AST].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:pf] =(pump[1]['PF'][0] / xiarray[:pf])*params[:W_PF].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:pr] =(pump[1]['PR'][0] / xiarray[:pr])*params[:W_PR].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:se] =(pump[1]['SE'][0] / xiarray[:pr])*params[:W_SE].to_f/100  }
            newarray
        end
    end
end
