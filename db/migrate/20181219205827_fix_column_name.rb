class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :electrical_cables, :maxTemp, :maxtemp
    rename_column :electrical_cables, :gasResistanceIndex, :gasresistanceindex
    rename_column :electrical_cables, :CorrosionResistance, :corrosionresistance

  end
end
