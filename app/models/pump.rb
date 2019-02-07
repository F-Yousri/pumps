class Pump < ApplicationRecord
    has_many :pump_properties, dependent: :destroy
    has_many :properties, through: :pump_properties, dependent: :destroy
    has_many :choices, through: :pump_properties, dependent: :destroy

    accepts_nested_attributes_for :pump_properties, allow_destroy: true
end
