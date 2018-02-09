class CreateMeasurements < ActiveRecord::Migration[5.1]
  def change
    create_table :measurements do |t|
      t.string :identifier
      t.integer :value
      t.belongs_to :instance, index: true

      t.timestamps
    end
  end
end
