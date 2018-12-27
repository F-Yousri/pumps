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
        when 'AvailablePumpingUnitTable'
            AvailablePumpingUnitTable.new
        when 'NemaTable'
            NemaTable.new
        when 'EspPerformanceCurfTable'
            EspPerformanceCurfTable.new
        when 'HouseTable'
            HouseTable.new
        when 'ESPMotorSpecification'
            ESPMotorSpecificationTable.new
        when 'ElectricalCable'
            ElectricalCableTable.new
        when 'JunctionBoxselectionTable'
            JunctionBoxselectionTable.new
        when 'PcpConditionTable'
            PcpConditionTable.new
        when 'PcpTable'
            PcpTable.new
        when 'StatorTable'
            StatorTable.new
        when 'RodTypeTorquLimitTable'
            RodTypeTorquLimitTable.new
        when 'DriveheadTable'
            DriveheadTable.new
        when 'EspcpTable'
            EspcpTable.new
        when 'EspcpModelTable'
            EspcpModelTable.new
        when 'VfsTable'
            VfsTable.new
        when 'TransformerTable'
            TransformerTable.new
        else

          raise 'Unsupported type of report'
        end
    end
 end 
 