class CreateInstances < ActiveRecord::Migration[5.1]
  def change
    create_table :instances do |t|
      t.string :serial_number
      t.string :note
      t.belongs_to :device, index: true

      t.timestamps
    end
  end
end
