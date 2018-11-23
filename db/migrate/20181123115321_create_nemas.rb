class CreateNemas < ActiveRecord::Migration[5.2]
  def change
    create_table :nemas do |t|
      t.float :motor_hp
      t.float :cost1
      t.float :cost2
      t.float :cost3
    end
  end
end
