class Renamestator < ActiveRecord::Migration[5.2]
  def change
    rename_column :stators, :Elastomer_type, :elastomer_type
    rename_column :stators, :Oil_API_from, :oil_api_from
    rename_column :stators, :Oil_API_to, :oil_api_to
    rename_column :stators, :Mechanical_resistance, :mechanical_resistance
    rename_column :stators, :GLR, :glr
    rename_column :stators, :Gas_Handling, :gas_handling



  end
end