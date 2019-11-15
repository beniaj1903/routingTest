class AddLoadSumToRoutes < ActiveRecord::Migration[5.2]
  def change
    add_column :routes, :load_sum, :integer
  end
end
