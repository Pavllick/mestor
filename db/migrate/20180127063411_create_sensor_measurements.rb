class CreateSensorMeasurements < ActiveRecord::Migration[5.1]
  def change
    create_table :sensor_measurements do |t|
      t.integer :value
      t.belongs_to :users_sensor, index: true

      t.timestamps
    end
  end
end
