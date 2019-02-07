class CreateDriveheads < ActiveRecord::Migration[5.2]
  def change
    create_table :driveheads do |t|
      t.string :gm
      t.float :max_torque
      t.float :max_speed
      t.integer :thrust_bearing
      t.integer :hp
      t.float :price

      t.timestamps
    end
  end
end
