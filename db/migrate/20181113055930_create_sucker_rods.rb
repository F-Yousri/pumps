class CreateSuckerRods < ActiveRecord::Migration[5.2]
  def change
    create_table :sucker_rods do |t|
      t.string :api
      t.string :Weatherford
      t.float :yield_strength
      t.string :corrosion_resistance

    end
  end
end
