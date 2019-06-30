module PhaseFour
    class << self
        def make (phaseoneresult ,pump ) 
            finalPumps = getonlyrightpump(phaseoneresult ,pump ) 
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
    end
end
