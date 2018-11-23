class CreateBarrelSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :barrel_sizes do |t|
      t.float :size

    end
  end
end

Available_Pumping_Units

rails  g model Available_Pumping_Units Max_GR:float 	PPRL:float	Max_Stroke_Length:float Stroke_lengths_1:float	Stroke_lengths_2:float Stroke_lengths_3:float Stroke_lengths_4:float cost:float


