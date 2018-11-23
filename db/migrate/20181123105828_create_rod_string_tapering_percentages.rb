class CreateRodStringTaperingPercentages < ActiveRecord::Migration[5.2]
  def change
    create_table :rod_string_tapering_percentages do |t|
      t.float  :Rod
      t.float :plunger_Diameter
      t.float :Rod_Weight
      t.float :size_118 , :null => true
      t.float :size_1 , :null => true
      t.float :size , :null => true
      t.float :_78 , :null => true
      t.float :size_34 , :null => true

    end
  end
end


rails  g model Barrel_sizes size:float