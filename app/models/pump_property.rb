class PumpProperty < ApplicationRecord
    validates :pump_id, uniqueness: { scope: [:property_id, :choice_id], 
    message: "Property option already exists"}
    belongs_to :pump
    belongs_to :property
    belongs_to :choice
end
