class CreateSensors < ActiveRecord::Migration[5.1]
  def change
    create_table :sensors do |t|
      t.string :mi_name
      t.string :mi_type_sign
      t.string :unit
      t.integer :upper_range_limit
      t.integer :lower_range_limit

      t.timestamps
    end
  end
end
