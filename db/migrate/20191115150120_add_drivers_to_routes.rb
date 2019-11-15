class AddDriversToRoutes < ActiveRecord::Migration[5.2]
  def change
    add_reference :routes, :driver, foreign_key: true
  end
end
