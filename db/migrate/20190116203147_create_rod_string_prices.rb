class CreateRodStringPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :rod_string_prices do |t|
      t.string :size
      t.float :k
      t.float :md
      t.float :d
      t.float :kd
      t.float :xd
      t.float :hd

      t.timestamps
    end
  end
end
