class Route < ApplicationRecord
    serialize :cities
    has_one :driver
    has_one :vehicle
end
