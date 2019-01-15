ActiveAdmin.register Stator do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
# 
permit_params :elastomer_type, :max_temp, :oil_api_from, :oil_api_to, :mechanical_resistance ,:api_index , :corrosives_resistance , :aromatics ,:gas_handling ,:glr ,:Application , :price_factor
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
