class CreateElectricalCables < ActiveRecord::Migration[5.2]
  def change
    create_table :electrical_cables do |t|
      t.string :model
      t.integer :maxTemp
      t.integer :gasResistanceIndex
      t.string :CorrosionResistance
      t.string :Insulation
      t.string :Jacket
      t.string :GasResistance
      t.float :a6
      t.float :a4
      t.float :a2
      t.float :a1
      t.float :price6
      t.float :price4
      t.float :price2
      t.float :price1
      t.timestamps
    end
  end
end
