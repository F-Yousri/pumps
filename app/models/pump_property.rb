class PumpProperty < ApplicationRecord
    belongs_to :pump
    belongs_to :property
    belongs_to :choice
end
