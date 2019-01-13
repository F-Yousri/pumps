  class SwitchboardTable

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input 
      @Availablekva=Switchboard.select('kva').map(&:kva)
      @new=@Availablekva.sort 
      @kva=@new.find { |e| e > input }  
      @ssw=Switchboard.select('model').where(kva: @kva)
      @ssw=@ssw[0]['model']
      {
        ssw:@ssw,
        kva:@kva
      }
      
    end 
  end