ActiveAdmin.register Tab do
    permit_params :name, properties_attributes: [:id, :name, :description, :choice_type, :_destroy]
  
    index do
      selectable_column
      id_column
      column :name
      column :properties do |tab|
        tab.properties.map {|p| p.name}.join(", ").html_safe
      end
      column :updated_at
      actions
    end
  
    filter :name
    filter :updated_at
  
    form do |f|
      f.semantic_errors *f.object.errors.keys
      f.inputs "Details" do
        f.input :name
      end
      f.has_many :properties, allow_destroy: true do |n_f|
        n_f.input :name
        n_f.input :description
        n_f.input :choice_type
        end
      f.actions
    end
  
  end
  