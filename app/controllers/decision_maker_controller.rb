class DecisionMakerController < ApplicationController
    require "#{Rails.root}/lib/phasetwo/table_generate.rb"
    Dir["#{Rails.root}/app/services/phasetwo/*.rb"].each {|file| require file }


    skip_before_action :verify_authenticity_token  

    def techEvalForm        
    end

    def techEval
        session[:params] ||= params
        @params = DecisionMakerService.make(params)
        render json:  params
    end

    def phaseTwoPump1
        @mina=PhaseTwoPumpOne.pumpone(params)
        render json:@mina
    end


    def phaseTwoPump2
        @mina=PhaseTwoPumpTwo.pumptwo(params)
        render json:@mina
    end
 

    def phaseTwoPump3
        @mina=PhaseTwoPumpThree.pumpthree(params)
        render json:@mina
    end


    def phaseTwoPump4
        @mina=PhaseTwoPumpFour.pumpfour(params)
        render json:@mina
      
    end

end
