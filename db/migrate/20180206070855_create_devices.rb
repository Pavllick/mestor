class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :mi_name
      t.string :mi_type_sign

      t.timestamps
    end
  end
end
