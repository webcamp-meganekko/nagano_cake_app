# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Customer.create!(email: "test@test.com", first_name: "名前", last_name: "名前", postal_code: "1234567",
first_name_kana: "ナマエ", last_name_kana: "ナマエ", password: "1234567", address: "北見市", tell: "09011112222")

Admin.create!(email: "test@test.com", password: "aaaaaa")

99.times do |n|
  first_name = "田中"
  last_name  = "太郎"
  first_name_kana = "タナカ"
  last_name_kana = "タロウ"
  email = "sample#{n+1}@test.com"
  password = "password"
  postal_code = "1234567"
  address = "札幌市"
  tell = "08011112222"
  Customer.create!(first_name:           first_name,
                  last_name:             last_name,
                  first_name_kana:       first_name_kana,
                  last_name_kana:        last_name_kana,
                  email:                 email,
                  password:              password,
                  password_confirmation: password,
                  postal_code:           postal_code,
                  address:               address,
                  tell:                  tell)
end