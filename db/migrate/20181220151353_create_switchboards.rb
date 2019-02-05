class CreateSwitchboards < ActiveRecord::Migration[5.2]
  def change
    create_table :switchboards do |t|
      t.string :model
      t.integer :kva
      t.integer :amperage
      t.integer :voltage
      t.integer :price

      t.timestamps
    end
  end
end
