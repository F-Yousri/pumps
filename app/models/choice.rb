class Choice < ApplicationRecord
    has_many :pump_property
    belongs_to :property
    has_many :pumps, through: :Pump_property
    
end
