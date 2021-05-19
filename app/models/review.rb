class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  
  validates :review, presence: true
end