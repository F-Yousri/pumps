class PumpsController < ApplicationController

  private

    def pump_params
      params.require(:pump).permit()
    end
end

