FactoryBot.define do
  factory :cart do
    product_id { 1 }
    customer_id { 1 }
    quantity { 2 }
  end
  
  factory :cart1, class: Cart do
    product_id { 2 }
    customer_id { 1 }
    quantity { 2 }
  end
end