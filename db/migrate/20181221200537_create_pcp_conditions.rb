class CreatePcpConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :pcp_conditions do |t|
      t.string :abrasives
      t.float :rpm
      t.float :eff_pcp

      t.timestamps
    end
  end
end
