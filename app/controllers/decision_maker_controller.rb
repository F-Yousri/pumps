class DecisionMakerController < ApplicationController
    def techEvalForm        
    end

    def techEval
        @decision = DecisionMakerService.make(params)
        if @decision === true
            flash.notice ='decision made'
        else
            flash.notice = 'nana'
        end
    end
end
