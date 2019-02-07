class FixFlowRate350EspcpModels < ActiveRecord::Migration[5.2]
  def change
    rename_column :espcp_models, :flow_rate350, :flow_rate350_from
    add_column :espcp_models, :flow_rate350_to, :float
  end
end
