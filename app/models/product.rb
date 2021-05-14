class Product < ApplicationRecord
  
  belongs_to :genre
  has_many :carts, dependent: :destroy
  has_many :order_products, dependent: :destroy

  attachment :image

  validates :genre_id, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_sale, presence: true
  validates :product_name, presence: true

  def is_sale_to_string
    if is_sale == true
      "販売中"
    else
      "販売停止中"
    end
  end
  
  def tax_included_price
    tax = 1.08
    price * tax
  end

end
