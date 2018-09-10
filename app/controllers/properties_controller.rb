class PropertiesController < ApplicationController

    def property_params
      params.require(:property).permit()
    end
end

