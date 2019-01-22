class CreateEconomicWeights < ActiveRecord::Migration[5.2]
  def change
    create_table :economic_weights do |t|
      t.string :factor
      t.integer :weight

      t.timestamps
    end
  end
end
