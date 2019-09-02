class Renamecolnames < ActiveRecord::Migration[5.2]
  def change
    rename_column :available_pumping_units, :Max_GR, :max_gr
    rename_column :available_pumping_units, :PPRL, :pprl
    rename_column :available_pumping_units, :Max_Stroke_Length, :max_stroke_length
  end
end
