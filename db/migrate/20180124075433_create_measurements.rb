class CreateMeasurements < ActiveRecord::Migration[5.1]
  def change
    create_table :measurements do |t|
      t.integer :value
      t.belongs_to :sensor, index: true

      t.datetime :created_at
    end
  end
end
