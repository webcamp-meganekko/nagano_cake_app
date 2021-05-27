FactoryBot.define do
  factory :address do
    customer_id {1}
    receve_name {Faker::Lorem.characters(number:5)}
    postal_code {Faker::Number.number(digits: 7)}
    street_address {Faker::Lorem.characters(number:7)}
  end
end