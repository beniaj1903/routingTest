class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :load_type
      t.integer :capacity
      t.timestamps
    end
  end
end
