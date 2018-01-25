class CreateSensors < ActiveRecord::Migration[5.1]
  def change
    create_table :sensors do |t|
      t.string :serial_number
      t.string :name
      t.string :unit
      t.integer :upper_range_limit
      t.integer :lower_range_limit

      t.timestamps
    end
  end
end
