  class MatchTable

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input 
    input = Choice.select('name').where(id: input).map(&:name)
    input[0]   
    end 
  end