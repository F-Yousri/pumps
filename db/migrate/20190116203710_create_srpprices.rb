class CreateSrpprices < ActiveRecord::Migration[5.2]
  def change
    create_table :srpprices do |t|
      t.float :pump_d
      t.float :tbg_p
      t.float :rod_p
      t.integer :corrosivity

      t.timestamps
    end
  end
end
