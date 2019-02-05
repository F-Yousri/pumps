class CreateAvailablePumpingUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :available_pumping_units do |t|
      t.float :Max_GR
      t.float :PPRL
      t.float :Max_Stroke_Length
      t.float :Stroke_lengths_1
      t.float :Stroke_lengths_3
      t.float :Stroke_lengths_2
      t.float :Stroke_lengths_4
      t.float :cost

    end
  end
end


