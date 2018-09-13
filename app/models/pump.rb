class Pump < ApplicationRecord
    has_many :pump_properties, dependent: :destroy
    has_many :properties, through: :pump_properties
    has_many :choices, through: :pump_properties

    accepts_nested_attributes_for :pump_properties, allow_destroy: true
end
