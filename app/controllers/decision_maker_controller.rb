class DecisionMakerController < ApplicationController
    require "#{Rails.root}/lib/phasetwo/table_generate.rb"
    Dir["#{Rails.root}/app/services/phasetwo/*.rb"].each {|file| require file }
    Dir["#{Rails.root}/app/services/phasethree/*.rb"].each {|file| require file }

    before_action :authenticate_user!
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
    $sorted
    
    def techEvalForm
        gon.readonlyProps = AdditionalCriterium.all.pluck( :name )
        gon.vals = AdditionalCriterium.all.pluck( :value )
    end

    def techEval
        $phaseoneparams=params
        @pumps = DecisionMakerService.make(params)
        @rightpumps = self.getonlyrightpumps( @pumps)
        @rightpumps.each do |pump|
            if pump.include?("ESP") 
                @resultpump2=self.phaseTwoPump2
            end
            if pump.include?("RRP") 
                @resultpump1=self.phaseTwoPump1
            end
            if pump.include?("ESPCP") 
                @resultpump4=self.phaseTwoPump4
            end
            if pump.include?("PCP") 
                @resultpump3=self.phaseTwoPump3
            end
        end
        @pumps = DecisionMakerService.make(params)
        @FinalPhase2={ "pump1" => @resultpump1, "pump2" => @resultpump2 , "pump3" =>@resultpump3, "pump4" => @resultpump4}
        @resultphasthree=self.phasethree @FinalPhase2
        @Final=@FinalPhase2.merge(@resultphasthree) 
        # render json:@Final
        # render json:@Final[:phasethreepump1]
        # render json:@resultpump2
        # render json:$phaseoneparams
        # render json:@resultpump3
        # render json:@FinalPhase2
        # render json:@resultphasthree
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

    def phasethree params
        @wsm={}
        if params["pump1"]
        @costpump1=self.phasethreepump1
        @wsm.merge!(RRP: @costpump1[:wsm] )
        end
        if params["pump2"]
        @costpump2=self.phasethreepump2
        @wsm.merge!(ESP: @costpump2[:wsm] )
        end
        if params["pump3"]
        @costpump3=self.phasethreepump3
        @wsm.merge!(PCP: @costpump3[:wsm] )
        end
        if params["pump4"]
        @costpump4=self.phasethreepump4
        @wsm.merge!(ESPCP: @costpump4[:wsm] )
        end
        @sorted=Hash[@wsm.sort_by{|k, v| v}]
        @keys=@sorted.keys
        @FinalPhase3={ "phasethreepump1" => @costpump1, "phasethreepump2" => @costpump2 , "phasethreepump3" =>@costpump3, "phasethreepump4" => @costpump4 }
         # render json:@FinalPhase3


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

    def getonlyrightpumps all_pumps
        rightpumps = all_pumps
        all_pumps.each_with_index do |pump , index|
            puts  index
            if ( (pump[1]["StE"].include?(1.0) ) ||
                 (pump[1]["WL"].include?(1.0) ) || 
                 (pump[1]["MD"].include?(1.0) ) || 
                 (pump[1]["WD"].include?(1.0) ) ||
                 (pump[1]["CSG_ND"].include?(1.0)) ||
                 (pump[1]["DS"].include?(1.0)) ||
                 (pump[1]["GQ"].include?(1.0)) || 
                 (pump[1]["J"].include?(1.0)) ||
                 (pump[1]["T_bh"].include?(1.0)) ||
                 (pump[1]["meo_m"].include?(1.0)) ||
                 (pump[1]["API"].include?(1.0)) ||
                 (pump[1]["AP"].include?(1.0)) || 
                 (pump[1]["CP"].include?(1.0)) ||
                 (pump[1]["ArP"].include?(1.0)) || 
                 (pump[1]["EP"].include?(1.0)) || 
                 (pump[1]["SP"].include?(1.0)) ||
                 (pump[1]["PP"].include?(1.0)) || 
                 (pump[1]["GLR"].include?(1.0))  ||
                 (pump[1]["APM"].include?(1.0)) || 
                 (pump[1]["AST"].include?(1.0)) || 
                 (pump[1]["PF"].include?(1.0)) || 
                 (pump[1]["PR"].include?(1.0)) || 
                 (pump[1]["SE"].include?(1.0)) )
                rightpumps.delete_at(index)
            end
        end
        return rightpumps
    end
end
