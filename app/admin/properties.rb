ActiveAdmin.register Property do
    menu priority: 4
    permit_params :name, tab_attributes: [:name], choices_attributes: [:id, :name, :_destroy]
  
    index do
      selectable_column
      id_column
      column :name
      column :tab
      column :choices do |property|
        property.choices.map {|ch| ch.name}.join(", ").html_safe
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
      f.has_many :choices, allow_destroy: true do |n_f|
        n_f.input :name
        end
      f.actions
    end
  
  end
  