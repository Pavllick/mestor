class Measurement < ApplicationRecord
  belongs_to :instance

  validates :identifier, :value, :instance_id, presence: true
  validates :value, numericality: { only_integer: true }

  scope :last_seconds, -> (analog_param, seconds) do
  	where(identifier: analog_param.identifier).
  	where(created_at: (seconds.seconds.ago)...Time.now).last(40)
  end
end
