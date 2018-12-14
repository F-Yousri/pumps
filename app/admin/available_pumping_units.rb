ActiveAdmin.register AvailablePumpingUnit do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :Max_GR, :PPRL, :Max_Stroke_Length, :Stroke_lengths_1, :Stroke_lengths_2 , :Stroke_lengths_3 , :Stroke_lengths_4 , :cost
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
end
