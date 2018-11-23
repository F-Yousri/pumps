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
rails g model Available_sucker_rod_pump_sizes Plunger_Diameter:float	Plunger_Area:float	Barrel_OD:float	min_Tubing_size:float	max_Tubing_size:float
