class AddNoteToProperties < ActiveRecord::Migration[5.2]
  def change
    add_column :properties, :note, :text
  end
end
