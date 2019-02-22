class CreateBarrelSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :barrel_sizes do |t|
      t.float :size

    end
  end
end


