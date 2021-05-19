class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  enum making_status: {着手不可:0, 製作待ち:1,  製作中:2, 製作完了:3}

  def tax_included_price
    tax = 1.08
    price * tax
  end
  
  #注文ステータスの
  def change_order_status
    products = self.order.order_products
    if self.making_status == "製作中"
      self.order.update(order_status: "製作中")
    elsif products.pluck(:making_status).all?{ |status| status == "製作完了"}
      self.order.update(order_status: "発送準備中")
    end
  end
  
end