class DecisionMakerController < ApplicationController
    def techEvalForm        
    end

    def techEval
        @params = DecisionMakerService.make(params)
        if @decision === true
            flash.notice ='decision made'
        else
            flash.notice = 'nana'
        end
        @params
    end
end
