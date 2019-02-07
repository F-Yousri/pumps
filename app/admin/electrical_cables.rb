ActiveAdmin.register ElectricalCable do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
menu :parent => "Database"

permit_params :model ,:maxTemp , :gasResistanceIndex , :CorrosionResistance , :Insulation, :Jacket, :GasResistance, :a6, :a4, :a2, :a1, :price6, :price4, :price2, :price1

# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end

