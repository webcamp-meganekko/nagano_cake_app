class Address < ApplicationRecord
  belongs_to :customer
  
  VALID_POSTCODE_REGEX = /\A\d{7}\z/
  validates :receve_name, presence: true
  validates :postal_code, presence: true, format: { with: VALID_POSTCODE_REGEX }
  validates :street_address, presence: true
end
