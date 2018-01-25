class Measurement < ApplicationRecord
  validates :value, :sensor_id, presence: true

  belongs_to :sensor
end
