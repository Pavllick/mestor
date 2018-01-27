class AuthorizedDevice < ApplicationRecord
  validates :mi_type_sign, :serial_number, presence: true
end
