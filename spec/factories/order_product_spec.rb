FactoryBot.define do
  factory :order_product do
    product_id { 1 }
    order_id { 1 }
    quantity { 2 }
    making_status { 0 }
    price { 600 }
  end
  factory :order_product2, class: OrderProduct do
    product_id { 2 }
    order_id { 1 }
    quantity { 1 }
    making_status { 0 }
    price { 200 }
  end
end