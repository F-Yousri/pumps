class InstallationCrewTable

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input
        @price=InstallationCrew.select('price').where(service: input).map(&:price)
        @price[0]
    end 
  end
