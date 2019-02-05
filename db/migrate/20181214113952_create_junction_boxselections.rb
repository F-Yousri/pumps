class CreateJunctionBoxselections < ActiveRecord::Migration[5.2]
  def change
    create_table :junction_boxselections do |t|
      t.float :kv
      t.float :cost

      t.timestamps
    end
  end
end
