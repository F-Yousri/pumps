  class EspcpTable 

    def prepare_input input
        final_input = input
        self.get_data final_input
    end

    def get_data input
        @AvailableThrustLoad=Espcp.select('thrust_load').map(&:thrust_load)
        @new=@AvailableThrustLoad.sort 
        @TC_s=@new.find { |e| e > input}
        @model=Espcp.select('model').where(thrust_load: @TC_s ).map(&:model)
        @data ={
            model: @model[0],
            TC_s: @TC_s
        }
        @data
    end 
  end


#   permit_params :model, :thrust_load
