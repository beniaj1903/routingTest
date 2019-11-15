class AddVehicleToRoutes < ActiveRecord::Migration[5.2]
  def change
    add_reference :routes, :vehicle, foreign_key: true
  end
end
