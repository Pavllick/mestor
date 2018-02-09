class Measurement < ApplicationRecord
  belongs_to :instance

  validates :identifier, :value, :instance_id, presence: true
  validates :value, numericality: { only_integer: true }
end
