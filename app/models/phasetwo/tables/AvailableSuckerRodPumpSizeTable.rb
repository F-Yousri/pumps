class AvailableSuckerRodPumpSizeTable 

    def prepare_input input
        @Plunger_Diameter=AvailableSuckerRodPumpSize.select('Plunger_Diameter').map(&:Plunger_Diameter)
        @new=@Plunger_Diameter.sort 
        @ID_p=@new.find { |e| e >= input }
        @data=AvailableSuckerRodPumpSize.where(Plunger_Diameter: @ID_p)
        @data[0]
    end

    def get_data input
    end 
  end


