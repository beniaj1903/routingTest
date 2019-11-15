class AddAvailableAtToDrivers < ActiveRecord::Migration[5.2]
  def change
    add_column :drivers, :available_at, :datetime
  end
end
