ActiveAdmin.register EspcpModel do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :pump_rating, :pump_maodel, :flow_rate350_from, :flow_rate500, :head, :motor_power, :Voltage, :Current, :min_casing_size, :Efficiency, :power_factor, :price ,:flow_rate750_to
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
