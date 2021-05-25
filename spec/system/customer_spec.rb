require 'rails_helper'

describe '登録〜注文のテスト' do

  context 'ログイン前' do

    it '新規登録画面へのリンクを押下すると新規登録画面が表示される' do
      visit root_path
      find(".fa-user-plus").click
      expect(current_path).to eq new_customer_registration_path
    end
  end
  
  describe 'サインイン後' do
    
    before do
      visit new_customer_registration_path
      fill_in 'customer[last_name]', with: "令和"
      fill_in 'customer[first_name]', with: "道子"
      fill_in 'customer[last_name_kana]', with: "レイワ"
      fill_in 'customer[first_name_kana]', with: "ミチコ"
      fill_in 'customer[email]', with: "customer@test.com"
      fill_in 'customer[postal_code]', with: "1234567"
      fill_in 'customer[address]', with: "東京都足立区"
      fill_in 'customer[tell]', with: "12345678900"
      fill_in 'customer[password]', with: "password"
      fill_in 'customer[password_confirmation]', with: "password"
      find(".sign-up-btn").click
    end
    
    context '新規登録画面のテスト' do
      
      it '新規登録画面で入力した情報が表示されている' do
        expect(current_path).to eq customer_show_path
        expect(page).to have_content "logged in"
        expect(page).to have_content "令和道子"
        expect(page).to have_content "レイワミチコ"
        expect(page).to have_content "customer@test.com"
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
      
      let!(:genre) {create(:genre)}
      let!(:product1) {create(:product)}
      let!(:product2) {create(:product)}
    
      it '商品画像を押下して該当商品の詳細画面に遷移する' do
        visit root_path
        find('a[href="/products/1"]').click
        expect(current_path).to eq product_path(1)
      end
      
      it '押下した商品の商品情報が正しく表示されている' do
        visit product_path(1)
        expect(page).to have_content product1.product_name
        expect(page).to have_content product1.introduction
        expect(page).to have_content product1.tax_included_price
        expect(page).to have_content product1.genre_id
        expect(product1.is_sale).to be true
      end
    end
  
  describe "商品詳細、カートのテスト" do
  
    let!(:genre) {create(:genre)}
    let!(:product1) {create(:product)}
    let!(:product2) {create(:product)}
    let!(:product_none) {create(:product_none)}
    
    it "販売停止商品の画面" do
      visit product_path(3)
      expect(page).to have_content "品切れ中"
      expect(page).not_to have_content product1.tax_included_price
    end
    
    context "販売中の商品画面テスト" do
      
    before do
      visit product_path(1)
      expect(page).to have_content "2"
      find("option[value='2']").select_option
      find(".btn").click
    end
      
      it "個数を選択し、カートに入れるボタンを押下すると、カート画面に遷移する" do
        expect(current_path).to eq carts_path
      end
      
      it "カートの中身が正しく表示されている、トップ画面への遷移" do
        expect(page).to have_content product1.product_name
        expect(page).to have_content product1.tax_included_price
        expect(page).to have_content product1.tax_included_price.to_i * 2
        expect(page).to have_select('cart[quantity]', selected: '2')
        find(".to_top").click
        expect(current_path).to eq root_path
      end
      
      it "２個目の商品をカートに追加"do
        visit product_path(2)
        find("option[value='3']").select_option
        find(".btn").click
        expect(current_path).to eq carts_path
        expect(page).to have_content product1.product_name
        expect(page).to have_content product2.product_name
        expect(page).to have_content product1.tax_included_price
        expect(page).to have_content product2.tax_included_price
        expect(page).to have_select('cart[quantity]', selected: '2')
        expect(page).to have_select('cart[quantity]', selected: '3')
      end
      
      it "カート画面の個数変更、注文画面へ遷移" do
        find("option[value='4']").select_option
        find(".edit").click
        expect(page).to have_content product1.product_name
        expect(page).to have_select('cart[quantity]', selected: '4')
        expect(page).to have_content product1.tax_included_price.to_i * 4
        find(".to_order").click
        expect(current_path).to eq new_order_path
      end
    end
  end
    
    describe "注文のテスト" do
      
      let!(:genre) {create(:genre)}
      let!(:product1) {create(:product)}
      let!(:product2) {create(:product)}
      let!(:cart1) {create(:cart)}
      let!(:cart2) {create(:cart1)}
      let!(:address) {create(:address)}
      
      def sum(carts)
        sum = 0
        carts.each{|cart| sum += (cart.product.price * 1.08).floor * cart.quantity }
        return sum
      end
      
      def order_date(products)
        order_product = []
        products.each do |product|
          order_product = product.product_name
        end
        return order_product
      end
      
      before do
        visit new_order_path
      end
        
      it "注文情報入力画面のテスト" do
        expect(page).to have_checked_field("クレジットカード")
        expect(page).to have_content "東京都足立区"
        expect(page).to have_checked_field("ご自身の住所")
        find("option[value='1']").select_option
        expect(page).to have_content(address.street_address)
      end
      
      it "注文情報入力~注文詳細画面のテスト" do
        choose "order_payment_method_銀行振込"
        choose "order_address_option_2"
        fill_in "order[postal_code]", with: 1234567
        fill_in "order[address]", with: "沖縄県那覇市"
        fill_in "order[receve_name]", with: "ガッキー"
        find(".btn").click
        expect(current_path).to eq orders_confirm_path
        expect(page).to have_content "1234567 沖縄県那覇市 ガッキー"
        expect(page).to have_content cart1.product.product_name
        expect(page).to have_content cart2.product.product_name
        expect(page).to have_content (cart1.product.price * 1.08).floor * cart1.quantity
        expect(page).to have_content sum([cart1,cart2])
        find(".btn").click
        expect(current_path).to eq orders_complete_path
        find(".fa-user").click
        expect(current_path).to eq customer_show_path
        click_on 'histry'
        expect(current_path).to eq orders_path
        expect(page).to have_content "沖縄県那覇市"
        expect(page).to have_content Order.find(1).products[1].product_name
        expect(page).to have_content Order.find(1).total_price.to_s(:delimited)
      end
    
   context "注文履歴画面のテスト" do
     
   
   end
     
    end
  
   end
end