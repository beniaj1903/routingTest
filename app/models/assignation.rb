class Assignation < ApplicationRecord
  belongs_to :route, dependent: :destroy
  belongs_to :driver, dependent: :destroy
  belongs_to :vehicle, dependent: :destroy
end
