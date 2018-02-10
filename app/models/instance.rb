class Instance < ApplicationRecord
  belongs_to :device, optional: true
  has_many :measurements

  validates :serial_number, presence: true

  attr_accessor :ext_value

  def validate_ext_value(ext_val)
  	if ext_val.length < 1
  		errors.add(:ext_value, I18n.t('model.instance.ext_value.empty'))
  	elsif !is_numeric?(ext_val)
  		errors.add(:ext_value, I18n.t('model.instance.ext_value.not_a_number'))
  	end
  end

  def is_numeric?(obj) 
   obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
	end
end
