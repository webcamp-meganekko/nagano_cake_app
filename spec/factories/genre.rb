FactoryBot.define do
  factory :genre do
    id { 1 }
    genre_name { "ケーキ" }
  end
  factory :genre2, class: Genre do
    id { 2 }
    genre_name { "マカロン" }
  end
end