module PhaseFour
    class << self
        def make (phaseoneresult,pump,resultphasthree ,params) 
            finalPumps = getonlyrightpump(phaseoneresult ,pump ) 
            cdcpumps = addcdc(finalPumps , resultphasthree)   
            # xiarray  = clacxi (cdcpumps)
            # newarray = newPumpArrayAfterdivXi(xiarray ,cdcpumps ,params)
            # bestandworst = getBestAndWorst(newarray)
            # bestarray = getbestarray( newarray ,bestandworst)
            # worst = getworstarray( newarray ,bestandworst)
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
            wl=md_pump=wd=csg_nd=ds=gq=j=t_bh=meo_m=api=ap=cp=arp=ep=sp=pp=glr=apm=ast=pf=pr=se=cdc=ste=0
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
            cdcpumps.each{ |pump|  ste =ste +  pump[1]['StE'][0].to_f**2  }
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
            xiarray[:ste] = Math.sqrt(ste)
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
            cdcpumps.each{ |pump| newarray[pump[0]][:glr] =(pump[1]['GLR'][0] / xiarray[:glr])*params[:W_GLR].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:apm] =(pump[1]['APM'][0] / xiarray[:apm])*params[:W_APM].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:ste] =(pump[1]['StE'][0] / xiarray[:ste])*params[:W_SE].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:ast] =(pump[1]['AST'][0] / xiarray[:ast])*params[:W_AST].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:pf] =(pump[1]['PF'][0] / xiarray[:pf])*params[:W_PF].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:pr] =(pump[1]['PR'][0] / xiarray[:pr])*params[:W_PR].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:se] =(pump[1]['SE'][0] / xiarray[:se])*params[:W_ES].to_f/100  }
            cdcpumps.each{ |pump| newarray[pump[0]][:cdc] =(pump[1]['cdc'] / xiarray[:cdc])*params[:W_NPV].to_f/100  }
            newarray
        end

        def getBestAndWorst newarray
            @wl=[]
            @md_pump=[]
            @wd=[]
            @csg_nd=[]
            @ds=[]
            @gq=[]
            @j=[]
            @t_bh=[]
            @meo_m=[]
            @api=[]
            @ap=[]
            @cp=[]
            @arp=[]
            @ep=[]
            @sp=[]
            @pp=[]
            @glr=[]
            @apm=[]
            @ast=[]
            @pf=[]
            @pr=[]
            @se=[]
            @cdc=[]
            @ste=[]
            newarray.each { |key, value| 
            @wl.push(value[:wl])
            @md_pump.push(value[:md_pump])
            @wd.push(value[:wd])
            @csg_nd.push(value[:csg_nd])
            @ds.push(value[:ds])
            @gq.push(value[:gq])
            @j.push(value[:j])
            @t_bh.push(value[:t_bh])
            @meo_m.push(value[:meo_m])
            @api.push(value[:api])
            @ap.push(value[:ap])
            @cp.push(value[:cp])
            @arp.push(value[:arp])
            @ep.push(value[:ep])
            @sp.push(value[:sp])
            @pp.push(value[:pp])
            @glr.push(value[:glr])
            @apm.push(value[:apm])
            @ast.push(value[:ast])
            @pf.push(value[:pf])
            @pr.push(value[:pr])
            @se.push(value[:se])
            @ste.push(value[:ste])
            @cdc.push(value[:cdc])


        }
            solution = {
                best:{
                wl:@wl.max,
                md_pump:@md_pump.max,
                wd:@wd.max,
                csg_nd:@csg_nd.max,
                ds:@ds.max,
                gq:@gq.max,
                j:@j.max,
                t_bh:@t_bh.max,
                meo_m:@meo_m.max,
                api:@api.max,
                ap:@ap.max,
                cp:@cp.max,
                arp:@arp.max,
                ep:@ep.max,
                sp:@sp.max,
                pp:@pp.max,
                glr:@glr.max,
                apm:@apm.max,
                ast:@ast.max,
                pf:@pf.max,
                pr:@pr.max,
                se:@se.max,
                cdc:@cdc.max,
                ste:@ste.max
            },
            worst:{
                wl:@wl.min,
                md_pump:@md_pump.min,
                wd:@wd.min,
                csg_nd:@csg_nd.min,
                ds:@ds.min,
                gq:@gq.min,
                j:@j.min,
                t_bh:@t_bh.min,
                meo_m:@meo_m.min,
                api:@api.min,
                ap:@ap.min,
                cp:@cp.min,
                arp:@arp.min,
                ep:@ep.min,
                sp:@sp.min,
                pp:@pp.min,
                glr:@glr.min,
                apm:@apm.min,
                ast:@ast.min,
                pf:@pf.min,
                pr:@pr.min,
                se:@se.min,
                cdc:@cdc.min,
                ste:@ste.min
            }}
        end

        def getbestarray( newarray ,bestandworst)
            bestarray={}
            newarray.each{ |pump ,values|  
            bestarray[pump]  ={}
            }
            newarray.each{ |key, value| 
            count = 0
            value.each { |k,v|
            count = count +(v.to_f-bestandworst[:worst][k].to_f)**2
            bestarray[key][k]= (v.to_f-bestandworst[:best][k].to_f)**2
            }
            bestarray[key]['si*']= Math.sqrt(count)
            }
            bestarray
        end

        def getworstarray( newarray ,bestandworst)
            worstarray={}
            newarray.each{ |pump ,values|  
            worstarray[pump]  ={}
            }
            newarray.each{ |key, value| 
            count = 0.0
            value.each { |k,v|
            count = count +(v.to_f-bestandworst[:worst][k].to_f)**2
            worstarray[key][k]= (v.to_f-bestandworst[:worst][k].to_f)**2
            }
            worstarray[key]['si-']= Math.sqrt(count)
            }
            worstarray
        end
    end
end
