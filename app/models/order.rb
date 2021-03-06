class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_products, dependent: :destroy

  validates :customer_id, :payment_method, :receve_name, :postal_code, :address, presence: true
  validates :postal_code,  presence: true, format: { with: /\A\d{7}\z/ }

  enum payment_method: {クレジットカード:0, 銀行振込:1}
  enum order_status: {入金待ち:0, 入金確認:1,  製作中:2, 発送準備中:3, 発送済み:4}

  def tax_included_price
   tax = 1.08
   price * tax
  end
  
  #製作ステータスの変更
  def change_making_status
    if self.order_status == "入金待ち"
      self.order_products.update_all(making_status: :着手不可)
    elsif self.order_status == "入金確認"
      self.order_products.update_all(making_status: :製作待ち)
    end
  end
end
