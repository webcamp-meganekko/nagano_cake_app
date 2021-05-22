# frozen_string_literal: true

require 'rails_helper'

FactoryBot.define do
  factory :customer do
    email { Faker::Internet.free_email }
    password { Faker::Internet.password }
    last_name { Gimei.last.kanji }
    first_name { Gimei.first.kanji }
    last_name_kana { Gimei.last.katakana }
    first_name_kana { Gimei.first.katakana }
    postal_code { Faker::Number.number(digits: 7) }
    address { Faker::Address.full_address }
    tell { Faker::Number.number(digits: 11) }
  end
end