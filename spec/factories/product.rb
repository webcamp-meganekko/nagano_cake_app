FactoryBot.define do
  factory :product do
    genre_id { 1 }
    product_name { Faker::Food.fruits }
    image_id { Faker::Lorem.characters(number:10) }
    introduction { Faker::Lorem.characters(number:10) }
    price { Faker::Number.number(digits: 4) }
  end
end