class CreateEspPerformanceCurves < ActiveRecord::Migration[5.2]
  def change
    create_table :esp_performance_curves do |t|
      t.string :pump_seris
      t.string :pump_type
      t.integer :minRate
      t.integer :maxRate
      t.integer :minCsg
      t.float :c1head
      t.float :c1hp
      t.float :c2head
      t.float :c2hp
      t.float :c3head
      t.float :c3hp
      t.float :c4head
      t.float :c4hp
      t.float :c5head
      t.float :c5hp
      t.float :c6head
      t.float :c6hp
      t.timestamps
    end
  end
end


