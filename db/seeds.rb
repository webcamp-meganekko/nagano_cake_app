# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Customer.create(email: "test@test.com", first_name: "名前", last_name: "名前", postal_code: "1234567",
first_name_kana: "ナマエ", last_name_kana: "ナマエ", password: "1234567", address: "北見市", tell: "09011112222")

Admin.create(email: "test@test.com", password: "aaaaaa")

