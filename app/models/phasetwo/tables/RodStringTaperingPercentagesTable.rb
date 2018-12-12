class RodStringTaperingPercentagesTable

    def prepare_input input
      RodStringTaperingPercentage.where(Rod: input[:SR_ND]).where(plunger_Diameter: input[:ID_p]).first(1)
    end

    def get_data input
    end 
  end


