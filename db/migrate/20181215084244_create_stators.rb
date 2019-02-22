class CreateStators < ActiveRecord::Migration[5.2]
  def change
    create_table :stators do |t|
      t.string :Elastomer_type
      t.float :max_temp
      t.integer :Oil_API_from
      t.integer :Oil_API_to
      t.string :Mechanical_resistance
      t.string :Api_index
      t.string :Corrosives_resistance
      t.string :Aromatics
      t.string :Gas_Handling
      t.integer :GLR
      t.string :Application
      t.float :price_factor

      t.timestamps
    end
  end
end

