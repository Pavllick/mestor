class ArbitraryParam < ApplicationRecord
  belongs_to :device

  validates :identifier, :name, :active, presence: true
  validates :identifier, format: { with: /\A[0-9a-z]+\z/,
    message: I18n.t('model.format.identifier') }
  validate :uniqueness_of_identifier

	private

	def uniqueness_of_identifier
		if device.discrete_params.map(&:identifier).count(identifier) > 1
			errors.add(:identifier, I18n.t('model.invalid.uniqueness.identifier.fail'))
			false
		else
			true
		end
	end
end
