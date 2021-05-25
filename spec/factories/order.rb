FactoryBot.define do
  factory :order do
    customer_id { 1 }
    postage { 800 }
    total_price { ((Product.find(1).price * 1.08).floor * Order.order_product.quantity) + 800 }
    delivery_name { "令和道子" }
    delivery_address {  }
    delivery_postcode { Faker::Address.postcode }
  end
end