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
      expect(page).to have_content '製作待ち'
    end
  end

   xcontext '製作ステータスを1つ「製作中」にする' do
    before do
      visit admin_order_path(1)
      # find("#tour_genre_id").find("option[value='1']").select_option
      # select('製作中', from: 'order_product[making_status]')
      find('#order_product_button').click
    end
    
    xit '注文ステータスが「入金確認」、製作ステータスが「製作待ち」に更新される' do
      expect(page).to have_content '製作待ち'
    end
  end
end