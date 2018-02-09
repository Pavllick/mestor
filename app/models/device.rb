class Device < ApplicationRecord
	has_many :analog_params, dependent: :destroy, inverse_of: :device
	has_many :discrete_params, dependent: :destroy, inverse_of: :device
	has_many :arbitrary_params, dependent: :destroy, inverse_of: :device

	accepts_nested_attributes_for :analog_params, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :discrete_params, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :arbitrary_params, reject_if: :all_blank, allow_destroy: true

	validates :mi_name, :mi_type_sign, presence: true

	enum mi_names: { burner_control: 0,
									 pressure_meter: 1,
									 temperature_meter: 2,
									 preasure_sensor: 3,
									 temperature_sensor: 4 }
end
