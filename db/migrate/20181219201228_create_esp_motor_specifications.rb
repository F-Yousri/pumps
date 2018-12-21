class CreateEspMotorSpecifications < ActiveRecord::Migration[5.2]
  def change
    create_table :esp_motor_specifications do |t|
      t.integer :motor
      t.string :pump
      t.integer :hp
      t.integer :Voltage
      t.integer :Amperage
      t.integer :Price

      t.timestamps
    end
  end
end
