class Driver < ApplicationRecord
    serialize :cities
    has_one: vehicle
end
