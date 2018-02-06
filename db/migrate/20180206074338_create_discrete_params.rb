class CreateDiscreteParams < ActiveRecord::Migration[5.1]
  def change
    create_table :discrete_params do |t|
      t.string :identifier
      t.string :name

      t.belongs_to :device, index: true
    end
  end
end
