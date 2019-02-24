  class NemaTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input
      @check=Nema.select('motor_hp').order("motor_hp DESC").first
      if ( input > @check[:motor_hp])
        input =  @check[:motor_hp]
      end
       @array=Nema.select('motor_hp').map(&:motor_hp)
       @array=@array.sort
       @MHP_srps=@array.find { |e| e >= input }
       @cost=Nema.select('cost1').where(motor_hp: @MHP_srps ).map(&:cost1)
       {
        MHP_srps:@MHP_srps,
        mcost:@cost[0]
       }
    end 
  end


