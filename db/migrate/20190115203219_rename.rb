class Rename < ActiveRecord::Migration[5.2]
  def change
    rename_column :stators, :Corrosives_resistance, :corrosives_resistance
    rename_column :stators, :Api_index, :api_index
    rename_column :stators, :Aromatics, :aromatics
  end
end
