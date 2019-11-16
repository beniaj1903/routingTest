class Assignation < ApplicationRecord
  belongs_to :route
  belongs_to :driver
  belongs_to :vehicle
end
