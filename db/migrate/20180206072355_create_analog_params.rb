class CreateAnalogParams < ActiveRecord::Migration[5.1]
  def change
    create_table :analog_params do |t|
    	t.string :identifier
    	t.string :name
      t.string :unit
      t.integer :upper_range_limit
      t.integer :lower_range_limit
      t.boolean :active

      t.belongs_to :device, index: true
    end
  end
end
