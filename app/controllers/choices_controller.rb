class ChoicesController < InheritedResources::Base

  private

    def choice_params
      params.require(:choice).permit()
    end
end

