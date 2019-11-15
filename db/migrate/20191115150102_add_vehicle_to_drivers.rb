class AddVehicleToDrivers < ActiveRecord::Migration[5.2]
  def change
    add_reference :drivers, :vehicle, foreign_key: true
  end
end
