ActiveAdmin.register AvailableSuckerRodPumpSize do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
menu :parent => "Database"

permit_params :Plunger_Diameter, :Plunger_Area, :Barrel_OD, :min_Tubing_size, :max_Tubing_size
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
