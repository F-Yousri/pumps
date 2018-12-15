class CreateRodTypeTorquLimits < ActiveRecord::Migration[5.2]
  def change
    create_table :rod_type_torqu_limits do |t|
      t.string :API
      t.string :Weatherford
      t.float :t34
      t.float :t78
      t.float :t1
      t.float :t118

      t.timestamps
    end
  end
end
