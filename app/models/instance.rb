class Instance < ApplicationRecord
  belongs_to :device, optional: true
  has_many :measurements

  validates :serial_number, presence: true
end
