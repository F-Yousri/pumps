ActiveAdmin.register Pcp do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :Imperial_Q, :Imperial_H, :min_tube_saize, :min_casing_diameter, :Stator_max_od , :rotor_drift_diameter , :rotor_orbital_diameter , :eccentricity , :rotor_minor_diameter ,:hydraulic_torque , :price
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
