  class JunctionBoxselectionTable 

    def prepare_input input
        final_input = input/1000
        self.get_data final_input
    end

    def get_data input
        @Availablekv=JunctionBoxselection.select('kv').map(&:kv)
        @new=@Availablekv.sort 
        @kv=@new.find { |e| e > input }
        @price=JunctionBoxselection.select('cost').where(kv: @kv).map(&:cost)
        @data={
            kv:@kv,
            Junctioncost:@price[0]
        }
    end 
  end


