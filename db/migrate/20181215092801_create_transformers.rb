class CreateTransformers < ActiveRecord::Migration[5.2]
  def change
    create_table :transformers do |t|
      t.integer :kva
      t.float :price
      t.timestamps  
    end
  end
end
