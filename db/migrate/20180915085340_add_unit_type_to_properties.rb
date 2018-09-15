class AddUnitTypeToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :unit_type, :integer
  end
end
