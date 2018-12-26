class CreateConductorSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :conductor_sizes do |t|
      t.integer :cable
      t.float :max_armp
      t.float :voltage

      t.timestamps
    end
  end
end
