class Vehicle < ApplicationRecord
    has_one :driver, dependent: :destroy
    has_many :assignation, foreign_key: :assignation_id
end
