class ChaneEcoType < ActiveRecord::Migration[5.2]
  def change
    change_column :economic_weights, :weight, :float

  end
end
