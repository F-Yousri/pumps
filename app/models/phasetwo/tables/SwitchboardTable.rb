  class SwitchboardTable

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input 
      @Availablekva=Switchboard.select('kva').map(&:kva)
      @new=@Availablekva.sort 
      @kva=@new.find { |e| e > input }  
      @data=Switchboard.where(kva: @kva)
      @ssw=@data[0]['model']
      @switchprice=@data[0]['price']
      {
        ssw:@ssw,
        kva:@kva,
        switchprice:@switchprice
      }
      
    end 
  end