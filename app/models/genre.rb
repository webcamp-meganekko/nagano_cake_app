class Genre < ApplicationRecord

  has_many :products
  validates :genre_name, presence: true

  def self.search(word)
    search = Genre.where(genre_name: "#{word}")
    @search_products = Product.where( genre_id: search)
  end

end
