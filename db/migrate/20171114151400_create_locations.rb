class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.datetime :retrieved_at
      t.integer :vehicle_id

      t.timestamps
    end
    add_index :locations, :vehicle_id
    add_index :locations, :retrieved_at
  end
end
