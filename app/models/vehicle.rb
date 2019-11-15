class Vehicle < ApplicationRecord
    has_one :driver, dependent: :destroy
end
