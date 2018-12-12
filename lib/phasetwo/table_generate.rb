class Tablegenerate
    require "#{Rails.root}/app/models/phasetwo/bootstrap.rb"

    attr_accessor :name

    def initialize(name)
     @name=name
    end

    def get_table
        case self.name 
        when 'SuckerRodTable'
            SuckerRodTable.new 
        when 'AvailableSuckerRodPumpSize'
            AvailableSuckerRodPumpSizeTable.new
        when 'RodStringTaperingPercentagesTable'
            RodStringTaperingPercentagesTable.new
        when 'BarrelSizesTable'
            BarrelSizesTable.new
        else
          raise 'Unsupported type of report'
        end
    end
 end 
 