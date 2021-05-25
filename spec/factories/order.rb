FactoryBot.define do
  factory :order do
    customer_id { 1 }
    postage { 800 }
    total_price { 2200 }
    payment_method { 0 }
    receve_name { '森' }
    postal_code { '1234567' }
    address { '東京都渋谷区' }
    order_status { 0 }
  end
end