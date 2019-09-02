  class AvailablePumpingUnitTable 

    def prepare_input input
        @PT=(input[:PT])/1000
        @PPRL=input[:PPRL]/100
        @params={PT: @PT,PPRL: @PPRL}
        self.get_data @params
    end

    def get_data params
        @AvailablePumpingUnit=AvailablePumpingUnit.select('Max_GR').map(&:Max_GR)
        @new=@AvailablePumpingUnit.sort 
        @PT1000=@new.find { |e| e > params[:PT] }
        @array=AvailablePumpingUnit.select('PPRL').where(Max_GR: @PT1000).map(&:PPRL)
        @array=@array.sort
        if ( params[:PPRL] > @array.last)
          params[:PPRL] = @array.last
        end
        @PPRL100=@array.find { |e| e >= params[:PPRL] }
        @SL=AvailablePumpingUnit.select('Max_Stroke_Length').where(PPRL: @PPRL100).where(Max_GR: @PT1000)
        @cost=AvailablePumpingUnit.select('cost').where(PPRL: @PPRL100).where(Max_GR: @PT1000).map(&:cost)
        @data={PPRL100: @PPRL100 ,PT1000:@PT1000,SL:@SL[0]['Max_Stroke_Length'] ,spuc:@cost[0]}
        # @TEST = AvailablePumpingUnit.where("Max_GR > ?", params[:PT]).where("PPRL > ?", params[:PPRL]).where("max_stroke_length > ?", 200).last

    end 
  end


