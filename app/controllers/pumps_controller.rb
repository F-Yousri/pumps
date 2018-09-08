class PumpsController < InheritedResources::Base

  private

    def pump_params
      params.require(:pump).permit()
    end
end

