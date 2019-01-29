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
    $costpump1
    $costpump2
    $costpump3
    $costpump4
    
    def techEvalForm        
    end

    def techEval
        $phaseoneparams=params
        @params = DecisionMakerService.make(params)
        @resultpump1=self.phaseTwoPump1
        @resultpump2=self.phaseTwoPump2
        @resultpump3=self.phaseTwoPump3
        @resultpump4=self.phaseTwoPump4
        @resultphasthree=self.phasethree
        @FinalPhase2={ "pump1" => @resultpump1, "pump2" => @resultpump2 , "pump3" =>@resultpump3, "pump4" => @resultpump4}
        @Final=@FinalPhase2.merge(@resultphasthree) 
        # render json:@Final
        # render json:@Final[:phasethreepump1]
        # render json:@FinalPhase2
        # render json:$phaseoneparams
        # render json:@resultphasthree['phasethreepump1']
        render  template: 'resultphaseone' 
    end

    def phaseTwoPump1
        @pump1=PhaseTwoPumpOne.pumpone($phaseoneparams)
        # session[:pump1] ||= @pump1
        $pump1=@pump1
        @pump1
        # render json:@pump1
    end


    def phaseTwoPump2
        @pump2=PhaseTwoPumpTwo.pumptwo(params ,$phaseoneparams)
        # session[:pump2] ||= @pump2
        $pump2=@pump2
        @pump2
        # render json:@pump2
    end
 

    def phaseTwoPump3
        @pump3=PhaseTwoPumpThree.pumpthree(params ,$phaseoneparams)
        # session[:pump3] ||= @pump3
        $pump3=@pump3
        @pump3
        # render json:@pump3
    end


    def phaseTwoPump4
        @pump4=PhaseTwoPumpFour.pumpfour(params ,$phaseoneparams)
        # session[:pump4] ||= @pump4
        $pump4=@pump4
        @pump4
        # render json:@pump4
      
    end

    def phasethree
        @costpump1=self.phasethreepump1
        @costpump2=self.phasethreepump2
        @costpump3=self.phasethreepump3
        @costpump4=self.phasethreepump4
        @FinalPhase3={ "phasethreepump1" => @costpump1, "phasethreepump2" => @costpump2 , "phasethreepump3" =>@costpump3, "phasethreepump4" => @costpump4}
        # render json:@FinalPhase3
        @FinalPhase3

    end

    def phasethreepump1
        @costpump1=PhaseThree.phasethreepump1($pump1,$phaseoneparams)
        $costpump1=@costpump1
        @costpump1
        # render json:@costpump1
    end

    def phasethreepump2
        @costpump2=PhaseThree.phasethreepump2($pump2,$phaseoneparams)
        $costpump2=@costpump2
        @costpump2
        # render json:@costpump2
    end

    def phasethreepump3
        @costpump3=PhaseThree.phasethreepump3($pump3,$phaseoneparams)
        $costpump3=@costpump3
        @costpump3
        # render json:@costpump3
    end

    def phasethreepump4 
        @costpump4=PhaseThree.phasethreepump4($pump4,$phaseoneparams)
        $costpump4=@costpump4
        @costpump4
        # render json:@costpump4
    end


    def showpumps 
        # render json:$pump2
        render  template: 'pump2',locals: { pump2: @pump2 }
    end

end
