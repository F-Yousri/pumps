class AddTypeToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :choice_type, :integer
  end
end
