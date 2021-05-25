Customer.create!(email: "test@test.com", first_name: "結衣", last_name: "星野", postal_code: "1234567",
first_name_kana: "ユイ", last_name_kana: "ホシノ", password: "1234567", address: "東京都渋谷区", tell: "09011112222")

5.times do |n|
  first_name = "源"
  last_name  = "新垣"
  first_name_kana = "ゲン"
  last_name_kana = "アラガキ"
  email = "sample#{n+1}@test.com"
  password = "password"
  postal_code = "1234567"
  address = "東京都足立区"
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

Admin.create!(email: "test@test.com", password: "aaaaaa")

["ケーキ","プリン","焼き菓子","キャンディ"].each do |name|
  Genre.create!({ genre_name: name})
end