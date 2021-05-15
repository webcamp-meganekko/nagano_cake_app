class Address < ApplicationRecord
  belongs_to :customer
  
  validates :receve_name, presence: true
  validates :postal_code, presence: true
  validates :street_address, presence: true
end
