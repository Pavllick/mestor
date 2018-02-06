class Device < ApplicationRecord
	has_many :analog_params, inverse_of: :device
	has_many :discrete_params, inverse_of: :device
	has_many :arbitrary_params, inverse_of: :device

	accepts_nested_attributes_for :analog_params, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :discrete_params, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :arbitrary_params, reject_if: :all_blank, allow_destroy: true

	validates :mi_name, :mi_type_sign, :unit, presence: true
end
