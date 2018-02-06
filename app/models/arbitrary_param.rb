class ArbitraryParam < ApplicationRecord
  belongs_to :device

  validates :identifier, :name, presence: true
end
