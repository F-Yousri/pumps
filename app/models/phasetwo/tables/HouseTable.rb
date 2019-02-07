  class HouseTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data params
        @AvailableStages=House.select('stages').where(pump: params[:type]).map(&:stages)
        @new=@AvailableStages.sort 
        @No_st=@new.find { |e| e > params[:No_st] }
        @housing=House.where(stages: @No_st).where(pump: params[:type])
        # @housing[0]
        # @data={housing: @housing[0] ,No_st:@No_st}
        @housing[0]
    end 
  end


