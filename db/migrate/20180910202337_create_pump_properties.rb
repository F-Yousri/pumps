class CreatePumpProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :pump_properties do |t|
      t.belongs_to :pump, index: true
      t.belongs_to :property, index: true
      t.belongs_to :choice, index: true
      t.integer :rating
      t.timestamps
    end
  end
end
