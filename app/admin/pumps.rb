ActiveAdmin.register Pump do
    menu priority: 3
    permit_params :name, :updated_at, pump_properties_attributes:  [:id, :pump_id, :property_id, :choice_id, :rating, :destroy]
    index do
      selectable_column
      id_column
      column :name
      column :properties do |pump|
        pump.pump_properties.map {|p| p.property.name + " " + p.choice.name + " = " + p.rating.to_s}.join(", ").html_safe      end
    #   column :updated_at
    #   column :property_ids
      actions
    end
    show do |pump|
      attributes_table do
        row :name
        row :properties do |pump|
          pump.pump_properties.map {|p| p.property.name + ":   " + p.choice.name + ", rating:  " + p.rating.to_s}.join("/n ").html_safe
        end
      end
    end

    form do |f|
      f.semantic_errors *f.object.errors.keys
      f.inputs "Details" do
        f.input :name
      end
      f.has_many :pump_properties, allow_destroy: true do |n_f|
        n_f.input :property
        n_f.input :choice
        n_f.input :rating
        end
      f.actions
    end
  end