class AddTabIdToProperties < ActiveRecord::Migration[5.2]
  def change
    add_reference :properties, :tab, foreign_key: true
  end
end
