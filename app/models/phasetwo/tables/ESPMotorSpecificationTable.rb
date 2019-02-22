  class ESPMotorSpecificationTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input
        @AvailableHp=EspMotorSpecification.select('hp').where(pump: input[:series]).map(&:hp)
        @new=@AvailableHp.sort 
        @hp=@new.find { |e| e > input[:HP_ESPm] }
        @data=EspMotorSpecification.where(pump: input[:series]).where(hp: @hp).first
        @data
    end 
  end


