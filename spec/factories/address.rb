FactoryBot.define do
  factory :address do
    customer_id {1}
    receve_name {"新垣源"}
    street_address {Gimei.address.kanji}
    postal_code {Faker::Number.number(digits: 7)}
  end
end