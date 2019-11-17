class AddNameToVehicles < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :name, :string
  end
end
