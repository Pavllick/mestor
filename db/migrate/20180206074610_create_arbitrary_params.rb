class CreateArbitraryParams < ActiveRecord::Migration[5.1]
  def change
    create_table :arbitrary_params do |t|
      t.string :identifier
      t.string :name
      t.boolean :active
      
      t.belongs_to :device, index: true
    end
  end
end
