  class PcpConditionTable

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input  
        @data=PcpCondition.select('rpm').where(abrasives: input).limit(1).map(&:rpm)
        @data[0]
    end 
  end


