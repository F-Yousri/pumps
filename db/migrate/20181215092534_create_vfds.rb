class CreateVfds < ActiveRecord::Migration[5.2]
  def change
    create_table :vfds do |t|
      t.string :model
      t.float :PMM
      t.float :price
      t.timestamps
    end
  end
end
