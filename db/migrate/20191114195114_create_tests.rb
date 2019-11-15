class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :name
      t.date :date
      t.integer :number

      t.timestamps
    end
  end
end
