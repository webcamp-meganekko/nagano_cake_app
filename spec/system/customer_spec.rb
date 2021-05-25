require 'rails_helper'

describe '登録〜注文のテスト' do

  context 'トップページのテスト' do
    let!(:customer) { create(:customer) }

    it '新規登録画面へのリンクを押下すると新規登録画面が表示される' do
      visit root_path
      find(".fa-user-plus").click
      expect(current_path).to eq new_customer_registration_path
    end
  end
  
  describe 'トップページ以降のテスト' do
    before do
      visit new_customer_registration_path
      fill_in 'customer[last_name]', with: "令和"
      fill_in 'customer[first_name]', with: "道子"
      fill_in 'customer[last_name_kana]', with: "レイワ"
      fill_in 'customer[first_name_kana]', with: "ミチコ"
      fill_in 'customer[email]', with: "sample@test.com"
      fill_in 'customer[postal_code]', with: "1234567"
      fill_in 'customer[address]', with: "東京都足立区"
      fill_in 'customer[tell]', with: "12345678900"
      fill_in 'customer[password]', with: "password"
      fill_in 'customer[password_confirmation]', with: "password"
      find(".sign-up-btn").click
    end
    
    context '新規登録画面のテスト' do
      it '必要事項を入力して登録ボタンを押下するとマイページに遷移する' do
        expect(current_path).to eq customer_show_path
      end
      
      it '新規登録画面で入力した情報が表示されている' do
        expect(page).to have_content "令和道子"
        expect(page).to have_content "レイワミチコ"
        expect(page).to have_content "sample@test.com"
        expect(page).to have_content "1234567"
        expect(page).to have_content "東京都足立区"
        expect(page).to have_content "12345678900"
      end
      
      it 'ヘッダーがログイン後の表示に変わっている' do
        expect(page).to have_link '', href: customer_show_path
        expect(page).to have_link '', href: products_path
        expect(page).to have_link '', href: carts_path
        expect(page).to have_link '', href: destroy_customer_session_path
      end
    end
      
    context 'ヘッダーロゴのテスト' do
      it 'ヘッダーロゴを押下してトップ画面に遷移することができる' do
        find(".btnshine").click
        expect(current_path).to eq root_path
      end
    end
    
    context 'トップ画面のテスト' do
      
      let!(:genre) { create(:genre) }
      let!(:product1) { create(:product) }
      let!(:product2) { create(:product) }
    
      it '商品画像を押下して該当商品の詳細画面に遷移する' do
        visit root_path
        find('a[href="/product/1"]').click
        expect(current_path).to eq product_path(1)
      end
    end
  end
end