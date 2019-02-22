class CreateHousings < ActiveRecord::Migration[5.2]
  def change
    create_table :housings do |t|
      t.integer :housing
      t.integer :stages
      t.float :cost
      t.string :type

      t.timestamps
    end
  end
end
