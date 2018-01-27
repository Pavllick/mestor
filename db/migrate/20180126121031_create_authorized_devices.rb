class CreateAuthorizedDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :authorized_devices do |t|
      t.string :mi_type_sign
      t.string :serial_number

      t.timestamps
    end
  end
end
