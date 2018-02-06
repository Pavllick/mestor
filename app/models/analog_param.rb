class AnalogParam < ApplicationRecord
  belongs_to :device

  validates :identifier, :name, presence: true
  validates :upper_range_limit, :lower_range_limit, presence: true,
            numericality: { only_integer: true }

  has_many :users_sensors

  enum mi_names: { preasure_sensor: 0,
									 temperature_sensor: 1 }
  enum units: { pascal: 0, k_pascal: 1, m_pascal: 2,
                celsius: 3,
                ampere: 4, volt: 5, watt: 6 }
end
