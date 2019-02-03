class RodStringPriceTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input
        input=input.downcase
        @pn6=RodStringPrice.select("#{input}").where(size: "6")
        @pn6=@pn6[0][input]
        @pn7=RodStringPrice.select("#{input}").where(size: "7")
        @pn7=@pn7[0][input]
        @pn8=RodStringPrice.select("#{input}").where(size: "8")
        @pn8=@pn8[0][input]
        @pn9=RodStringPrice.select("#{input}").where(size: "9")
        @pn9=@pn9[0][input]
        {
            pn6:@pn6,
            pn7:@pn7,
            pn8:@pn8,
            pn9:@pn9
        }
    end 
  end
