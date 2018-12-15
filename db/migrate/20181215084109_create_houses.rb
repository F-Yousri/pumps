class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.integer :housing
      t.integer :stages
      t.float :cost
      t.string :pump
      t.timestamps
    end
  end
end
