module PhaseFour
    class << self
        def make (phaseoneresult,pump,resultphasthree) 
            finalPumps = getonlyrightpump(phaseoneresult ,pump ) 
            cdcpumps = addcdc(finalPumps , resultphasthree)
        end


        def getonlyrightpump (phaseoneresult ,pump ) 
            finalphaseone =[];
            @phaseoneresult = phaseoneresult
            for i in 0..pump.length
                if (pump[i] == phaseoneresult[i][0] )
                    finalphaseone.push(phaseoneresult[i])
                    puts pump[i]
                    puts phaseoneresult[i][0]
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
    end
end
