  class BarrelSizesTable 

    def prepare_input input
        @sizes=BarrelSize.select('size').map(&:size)
        @new=@sizes.sort 
        @new.find { |e| e > input }
    end

    def get_data input
    end 
  end


