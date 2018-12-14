ActiveAdmin.register EspPerformanceCurf do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params  :pump_seris, :pump_type , :minRate , :maxRate, :minCsg, :c1head, :c1hp, :c2head, :c2hp, :c3head, :c3hp, :c4head, :c4hp, :c5head, :c5hp, :c6head, :c6hp
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
