class CreateInstallationCrews < ActiveRecord::Migration[5.2]
  def change
    create_table :installation_crews do |t|
      t.string :service
      t.float :price

      t.timestamps
    end
  end
end
