class Choice < ApplicationRecord
    belongs_to :pump_property
    has_one :property, through: :Pump_property
end
