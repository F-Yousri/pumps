class CreatePcps < ActiveRecord::Migration[5.2]
  def change
    create_table :pcps do |t|
      t.integer :Imperial_Q
      t.integer :Imperial_H
      t.float :min_tube_saize
      t.integer :min_casing_diameter
      t.float :Stator_max_od
      t.float :rotor_drift_diameter
      t.float :rotor_orbital_diameter
      t.float :eccentricity
      t.float :rotor_minor_diameter
      t.integer :hydraulic_torque
      t.float :price

      t.timestamps
    end
  end
end