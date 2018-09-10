class AddPropertyIdToChoices < ActiveRecord::Migration[5.2]
  def change
    add_reference :choices, :property, foreign_key: true
  end
end
