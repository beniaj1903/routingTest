class StartTimeValidator < ActiveModel::Validator
    def validate(record)
        if record.starts_at > record.ends_at
            record.errors[:starts_at] << 'La hora de inicio de la ruta no puede ser menor a su hora de fin'
        end
    end
  end

class Route < ApplicationRecord
    validates_with StartTimeValidator
    serialize :cities
    has_one :driver
    has_one :vehicle
    has_one :assignation, dependent: :destroy
    before_create :correct_times
end

