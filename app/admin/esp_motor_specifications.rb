ActiveAdmin.register EspMotorSpecification do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
menu :parent => "Database"

permit_params :motor, :pump, :hp, :Voltage, :Amperage , :Price
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end