class CreateEspcpModels < ActiveRecord::Migration[5.2]
  def change
    create_table :espcp_models do |t|
      t.string :pump_rating
      t.string :pump_maodel
      t.float :flow_rate350
      t.float :flow_rate500
      t.float :head
      t.float :motor_power
      t.float :Voltage
      t.float :Current
      t.float :min_casing_size
      t.float :Efficiency
      t.float :power_factor
      t.float :price
      t.timestamps
    end
  end
end
