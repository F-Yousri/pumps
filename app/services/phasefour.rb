module PhaseFour
    class << self
        def make (phaseoneresult,pump,resultphasthree) 
            finalPumps = getonlyrightpump(phaseoneresult ,pump ) 
            cdcpumps = addcdc(finalPumps , resultphasthree)   
            xiarray  = clacxi (cdcpumps)
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
            wl=md_pump=wd=csg_nd=ds=gq=j=t_bh=meo_m=api=ap=cp=arp=ep=sp=0
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

            xiarray[:wl] = Math.sqrt(wl)
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


            xiarray
        end
    end
end
