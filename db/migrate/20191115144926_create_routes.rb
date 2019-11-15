class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :load_type
      t.text :cities
      t.integer :stops_amount
      t.timestamps
    end
  end
end
