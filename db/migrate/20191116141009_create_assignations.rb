class CreateAssignations < ActiveRecord::Migration[5.2]
  def change
    create_table :assignations do |t|
      t.references :route, foreign_key: true
      t.references :driver, foreign_key: true
      t.references :vehicle, foreign_key: true

      t.timestamps
    end
  end
end
