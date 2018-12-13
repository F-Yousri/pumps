  class NemaTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input
       @array=Nema.select('motor_hp').map(&:motor_hp)
       @array=@array.sort
       @MHP_srps=@array.find { |e| e > input }
    end 
  end


