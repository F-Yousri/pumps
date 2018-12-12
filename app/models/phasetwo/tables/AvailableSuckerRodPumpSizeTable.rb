class AvailableSuckerRodPumpSizeTable 

    def prepare_input input
        @Plunger_Diameter=AvailableSuckerRodPumpSize.select('Plunger_Diameter').map(&:Plunger_Diameter)
        @new=@Plunger_Diameter.sort 
        @new.find { |e| e > input }
    end

    def get_data input
    end 
  end


