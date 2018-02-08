class DiscreteParam < ApplicationRecord
	belongs_to :device

	validates :identifier, :name, :active, presence: true
end
