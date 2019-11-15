class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :name
      t.integer :phone
      t.string :email
      t.text :cities
      t.integer :max_number_of_stops

      t.timestamps
    end
  end
end
