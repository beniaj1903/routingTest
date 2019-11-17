class Vehicle < ApplicationRecord
    has_one :driver
    has_many :assignation, foreign_key: :assignation_id
end
