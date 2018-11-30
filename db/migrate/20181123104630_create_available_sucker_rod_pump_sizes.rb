class CreateAvailableSuckerRodPumpSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :available_sucker_rod_pump_sizes do |t|
      t.float :Plunger_Diameter
      t.float :Plunger_Area
      t.float :Barrel_OD
      t.float :min_Tubing_size
      t.float :max_Tubing_size
    end
  end
end


