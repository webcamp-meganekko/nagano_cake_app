class Address < ApplicationRecord
  belongs_to :customers
  
  validates :receve_name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
end
