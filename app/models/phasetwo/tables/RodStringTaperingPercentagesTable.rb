class RodStringTaperingPercentagesTable

    def prepare_input input
      if input[:pump] == 2
      RodStringTaperingPercentage.where(Rod: input[:SR_ND]).where(plunger_Diameter: input[:ID_p]).first(1)
      elsif input[:pump] == 3
        @array=RodStringTaperingPercentage.where(Rod: input[:SR_ND]).first(1)
        @array[0][:Rod_Weight]
      end
    end

    def get_data input
    end 
  end


