class AnalogParam < ApplicationRecord
  belongs_to :device

  validates :identifier, :name, :unit, :active, presence: true
  validates :upper_range_limit, :lower_range_limit, presence: true,
            numericality: { only_integer: true }
  validates :identifier, format: { with: /\A[0-9a-z]+\z/,
    message: I18n.t('model.format.identifier') }
  validate :uniqueness_of_identifier
  
  enum units: { pascal: 0, k_pascal: 1, m_pascal: 2,
                celsius: 3,
                ampere: 4, volt: 5, watt: 6 }

  private

  def uniqueness_of_identifier
    if device.analog_params.map(&:identifier).count(identifier) > 1
      errors.add(:identifier, I18n.t('model.device.uniqueness.identifier.fail'))
      false
    else
      true
    end
  end
end
