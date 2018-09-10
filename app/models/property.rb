class Property < ApplicationRecord
    validates   :name,  :presence => true,
                        :length => { :maximum => 100 }
    has_many :choices
    has_many :pump_properties
    has_many :pumps, through: :pump_properties
    accepts_nested_attributes_for :choices, allow_destroy: true
    accepts_nested_attributes_for :pump_properties, allow_destroy: true

end
