  class AdditionalCriteriumTable

    def prepare_input input
        self.get_data input
    end

    def get_data input   
     @se_rrp=AdditionalCriterium.select('value').where(name: input).map(&:value)
     @se_rrp[0]
    end 
  end