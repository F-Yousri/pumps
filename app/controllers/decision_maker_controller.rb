class DecisionMakerController < ApplicationController
    def techEvalForm        
    end

    def techEval
        @params = DecisionMakerService.make(params)

        @params
    end
end
