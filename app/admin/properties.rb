ActiveAdmin.register Property do
    menu priority: 4
    permit_params :name, choices_attributes: [:id, :name, :destroy]
  
    index do
      selectable_column
      id_column
      column :name
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
      f.actions
    end
  
  end
  