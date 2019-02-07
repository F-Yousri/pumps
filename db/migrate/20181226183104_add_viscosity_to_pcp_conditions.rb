class AddViscosityToPcpConditions < ActiveRecord::Migration[5.2]
  def change
    add_column :pcp_conditions, :viscosity, :float
    rename_column :espcp_models, :flow_rate350_to, :flow_rate750_to
    rename_column :pcp_conditions, :eff_pcp, :eff_pcp_to
    add_column :pcp_conditions, :eff_pcp_from, :float
  end
end
