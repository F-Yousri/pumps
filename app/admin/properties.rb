ActiveAdmin.register Property do
    menu priority: 4
    permit_params :name, :description, :choice_type, :note, :unit_type, tab_attributes: [:name], choices_attributes: [:id, :name, :_destroy]
  
    index do
      selectable_column
      id_column
      column :name
      column :description
      column :note
      column :unit_type    
      column :choice_type
      column :tab
      column :choices do |property|
        property.choices.map {|ch| ch.name}.join(", ").html_safe
      end
      column :updated_at
      actions
    end
  
    filter :name
    filter :description
    filter :choice_type
    filter :updated_at
  
    form do |f|
      f.semantic_errors *f.object.errors.keys
      f.inputs "Details" do
        f.input :name
        f.input :description
        f.input :note
        f.input :unit_type
        f.input :choice_type
      end
      f.has_many :choices, allow_destroy: true do |n_f|
        n_f.input :name
        end
      f.actions
    end
  
  end
  