class Driver < ApplicationRecord
    serialize :cities
    has_one :vehicle, dependent: :destroy
    has_many :assignation, foreign_key: :assignation_id
end
