class CreateVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :identity

      t.timestamps
    end
    add_index :vehicles, :identity, unique: true
  end
end
