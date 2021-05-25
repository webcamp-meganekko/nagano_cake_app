FactoryBot.define do
  factory :product do
    genre_id { 1 }
    product_name { 'ケーキ' }
    introduction { 'いちごのショートケーキ' }
    price { 300 }
  end
  factory :product2, class: Product do
    genre_id { 2 }
    product_name { 'マカロン' }
    introduction { 'カラフルなおかし' }
    price { 200 }
  end
end