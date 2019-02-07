class ChoicesController < ApplicationController

  private

    def choice_params
      params.require(:choice).permit()
    end
end

