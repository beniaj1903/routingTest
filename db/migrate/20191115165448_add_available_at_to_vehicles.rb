class AddAvailableAtToVehicles < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :available_at, :datetime
  end
end
