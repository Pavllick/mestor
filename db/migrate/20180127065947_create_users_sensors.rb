class CreateUsersSensors < ActiveRecord::Migration[5.1]
  def change
    create_table :users_sensors do |t|
      t.string :serial_number
      t.text :note
      t.boolean :authorized, default: false
      t.belongs_to :sensor, index: true

      t.timestamps
    end
  end
end
