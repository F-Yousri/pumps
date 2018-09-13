ActiveAdmin.register Choice do
    belongs_to :property
    permit_params :name, :property
  
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
      f.inputs do
        f.input :name
      end
      f.actions
    end
  
  end
  