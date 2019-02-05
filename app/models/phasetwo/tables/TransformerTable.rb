  class TransformerTable

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input   
      @AvailableTransformer=Transformer.select('kva').map(&:kva)
      @new=@AvailableTransformer.sort 
      @kva=@new.find { |e| e > input }
      @data=Transformer.where(kva: @kva)
      @price=@data[0][:price]
      {
        kva:@kva,
        price:@price
      }

    end 
  end