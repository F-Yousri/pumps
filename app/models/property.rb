class Property < ApplicationRecord
    enum choice_type: [:list_box, :text_box, :radio_box, :calculated]
    enum unit_type: [:depth, :pressure, :rate, :rate_per_pressure, :weight, :viscosity, :angle, :angle_per_depth, :temperature, :non]

    validates   :name,  :presence => true,
                        :length => { :maximum => 100 }
    has_many :choices, dependent: :destroy
    accepts_nested_attributes_for :choices, allow_destroy: true
    belongs_to :tab
    has_many :pump_properties, dependent: :destroy
    has_many :pumps, through: :pump_properties, dependent: :destroy
    accepts_nested_attributes_for :pump_properties, allow_destroy: true

end
