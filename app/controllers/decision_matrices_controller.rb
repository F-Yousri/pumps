class DecisionMatricesController < InheritedResources::Base

  private

    def decision_matrix_params
      params.require(:decision_matrix).permit()
    end
end

