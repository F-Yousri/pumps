ActiveAdmin.register RodStringTaperingPercentage do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :Rod, :plunger_Diameter, :Rod_Weight, :size_118, :size_1 , :size_78 , :size_34
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
