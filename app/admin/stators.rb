ActiveAdmin.register Stator do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
# 
permit_params :Elastomer_type, :max_temp, :Oil_API_from, :Oil_API_to, :Mechanical_resistance ,:Api_index , :Corrosives_resistance , :Aromatics ,:Gas_Handling ,:GLR ,:Application , :price_factor
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
