class PumpPropertiesController < InheritedResources::Base

  private

    def pump_property_params
      params.require(:pump_property).permit()
    end
end

