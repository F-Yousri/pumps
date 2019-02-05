class CreateEspcps < ActiveRecord::Migration[5.2]
  def change
    create_table :espcps do |t|
      t.string :model
      t.float :thrust_load
      t.timestamps
    end
  end
end
