class RenameColPcp < ActiveRecord::Migration[5.2]
  def change
    rename_column :pcp_conditions, :eff_pcp_to, :eff_pcp
    rename_column :pcp_conditions, :eff_pcp_from, :viscosity_to
    rename_column :pcp_conditions, :viscosity, :viscosity_from

  end
end
