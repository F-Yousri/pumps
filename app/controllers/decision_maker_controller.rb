class DecisionMakerController < ApplicationController
    require "#{Rails.root}/lib/phasetwo/table_generate.rb"
    Dir["#{Rails.root}/app/services/phasetwo/*.rb"].each {|file| require file }
    Dir["#{Rails.root}/app/services/phasethree/*.rb"].each {|file| require file }

    skip_before_action :verify_authenticity_token
    $phaseoneparams
    $pump1
    $pump2
    $pump3
    $pump4
    
    def techEvalForm        
    end

    def techEval
        session[:params] ||= params
        $phaseoneparams=params
        @params = DecisionMakerService.make(params)
        @resultpump1=self.phaseTwoPump1
        @resultpump2=self.phaseTwoPump2
        @FinalPhase2={ "pump1" => @resultpump1, "pump2" => @resultpump2 }
        # render json:@FinalPhase2
        # render json:$phaseoneparams
        # render  template: 'resultphaseone' , locals: { pumps: @params }
    end

    def phaseTwoPump1
        @pump1=PhaseTwoPumpOne.pumpone($phaseoneparams)
        session[:pump1] ||= @pump1
        $pump1=@pump1
        @pump1
        # render json:@pump1
    end


    def phaseTwoPump2
        @pump2=PhaseTwoPumpTwo.pumptwo(params ,$phaseoneparams)
        session[:pump2] ||= @pump2
        $pump2=@pump2
        # render json:@pump2
    end
 

    def phaseTwoPump3
        @pump3=PhaseTwoPumpThree.pumpthree(params ,$phaseoneparams)
        session[:pump3] ||= @pump3
        $pump3=@pump3
        # render json:@pump3
    end


    def phaseTwoPump4
        @pump4=PhaseTwoPumpFour.pumpfour(params ,$phaseoneparams)
        session[:pump4] ||= @pump4
        $pump4=@pump4
        # render json:@pump4
      
    end

    def phasethreepump1
        @cost=PhaseThree.phasethreepump1($pump1)
        render json:@cost
    end

end
