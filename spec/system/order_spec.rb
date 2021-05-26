require 'rails_helper'

describe '管理者' do
  let!(:admin) { create(:admin) }
  let!(:customer) { create(:customer) }
  let!(:genre) { create(:genre) }
  let!(:genre2) { create(:genre2) }
  let!(:product) { create(:product) }
  let!(:product2) { create(:product2) }
  let!(:order) { create(:order) }
  let!(:order_product) { create(:order_product) }
  let!(:order_product2) { create(:order_product2) }

  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button type: 'submit'
  end
  context 'メールアドレス・パスワードでログインする' do
    it 'トップ画面が表示される' do
      expect(current_path).to eq '/admin'
    end
  end
  
  context 'ヘッダから注文履歴一覧へのリンクを押下する' do
    before do
      find('.fa-clipboard-list').click
    end
    it '注文履歴一覧画面が表示される' do
      expect(current_path).to eq '/admin'
    end
  end
  context '注文の詳細表示ボタンを押下する' do
    before do
      visit admin_top_path
      find('.created_link').click
    end
    it '注文詳細画面が表示される' do
      expect(current_path).to eq '/admin/orders/1'
    end
  end
  
  context '注文ステータスを「入金確認」にする' do
    before do
      visit admin_order_path(1)
      select '入金確認', from: 'order[order_status]'
      find('#order_button').click
    end
    
    it '注文ステータスが「入金確認」、製作ステータスが「製作待ち」に更新される' do
      expect(page).to have_select('order[order_status]', selected: '入金確認')
      expect(page).to have_content '製作待ち'
    end
  end

  context '製作ステータスを1つ「製作中」にする' do
    before do
      visit admin_order_path(1)
      find_all('td')[4].select('製作中', from: 'order_product[making_status]')
      find_all('#order_product_button')[0].click
    end
    
    it '注文ステータスが「製作中」に更新される' do
      expect(page).to have_content '製作中'
    end
  end
  
  context '製作ステータスを全て「製作完了」にする' do
    before do
      visit admin_order_path(1)
      find_all('td')[4].select('製作完了', from: 'order_product[making_status]')
      find_all('#order_product_button')[0].click
      find_all('td')[9].select('製作完了', from: 'order_product[making_status]')
      find_all('#order_product_button')[1].click
    end
    
    it '注文ステータスが「発送準備中」に更新される' do
      expect(page).to have_content '発送準備中'
    end
  end
  
  context '注文ステータスを「発送済み」にする' do
    before do
      visit admin_order_path(1)
      select '発送済み', from: 'order[order_status]'
      find('#order_button').click
    end
    
    it '注文ステータスが「発送済み」に更新される' do
      expect(page).to have_select('order[order_status]', selected: '発送済み')
    end
  end
  
  context 'ヘッダからログアウトボタンを押下する' do
    before do
      find('.fa-sign-out-alt').click
    end
    
    it '管理者ログイン画面に遷移する' do
      expect(current_path).to eq '/admins/sign_in'
    end
  end
end

describe 'ECサイト' do
  let!(:customer) { create(:customer) }
  let!(:genre) { create(:genre) }
  let!(:genre2) { create(:genre2) }
  let!(:product) { create(:product) }
  let!(:product2) { create(:product2) }
  let!(:order) { create(:order) }
  let!(:order_product) { create(:order_product) }
  let!(:order_product2) { create(:order_product2) }
  
  before do
    visit new_customer_session_path
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button type: 'submit'
  end
  
  context '注文した会員情報でログインをする' do
    subject { page }
    
    it 'トップ画面に遷移する' do
      expect(current_path).to eq '/customers/my_page'
    end
    
    it 'ヘッダがログイン後の表示に変わっている' do
      is_expected.to have_link '', href: "/customers/my_page"
      is_expected.to have_link '', href: "/products"
      is_expected.to have_link '', href: "/carts"
      is_expected.to have_link '', href: "/customers/sign_out"
    end
  end
    
  context 'ヘッダからマイページに遷移する' do
    before do
      find('.fa-user').click
    end
    
    it 'マイページが表示される' do
      expect(current_path).to eq '/customers/my_page'
    end
  end
  
  context '注文履歴一覧を表示するボタンを押下する' do
    before do
      click_link href: orders_path
    end
    
    it '注文履歴一覧に遷移する' do
      expect(current_path).to eq '/orders'
    end
  end
    
  context '注文履歴から先ほど注文した注文の詳細表示ボタンを押下する' do
    before do
      visit orders_path
      click_link href: order_path(1)
    end
    
    it '注文履歴詳細画面に遷移する' do
      expect(current_path).to eq '/orders/1'
    end
  end
end