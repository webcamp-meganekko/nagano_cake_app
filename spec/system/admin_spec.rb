require 'rails_helper'

describe 'マスタ登録' do
  let(:admin) { create(:admin) }
  let!(:genre) { create(:genre) }
  before do
    visit new_admin_session_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    click_button type: 'submit'
  end
  
  describe 'ログイン画面' do

    context 'メールアドレス・パスワードでログインする' do
      it '管理者トップ画面が表示される' do
        expect(current_path).to eq '/admin'
      end
    end
  end
  
  describe '管理者トップ画面' do
    
    context 'ヘッダからジャンル一覧へのリンクを押下する' do
      before do
        visit admin_top_path
        find('.fa-venus-mars').click
      end
      
      it 'ジャンル一覧画面が表示される' do
        expect(current_path).to eq '/admin/genres'
      end
    end
  end
  
  describe 'ジャンル一覧画面' do
    
    context '必要事項を入力し、登録ボタンを押下する' do
      before do
        visit admin_genres_path
        fill_in 'genre[genre_name]', with: 'マカロン'
        click_button type: 'submit'
      end
      
      it '追加したジャンルが表示されている'do
        expect(page).to have_content 'マカロン'
      end
    end
    
    context 'ヘッダから商品一覧へのリンクを押下する' do
      before do
        find('.fa-cheese').click
      end
      
      it '商品一覧画面が表示される' do
        expect(current_path).to eq '/admin/products'
      end
    end
  end
  
  describe '商品一覧画面' do

    context '新規登録ボタンを押下する'do
      before do
        visit admin_products_path
        find('.new-products').click
      end
      
      it '商品新規登録画面が表示される' do
        expect(current_path).to eq '/admin/products/new'
      end
    end
  end

  describe '商品新規登録から商品一覧画面確認まで（２回）' do
    before do
      visit new_admin_product_path
      select 'ケーキ', from: 'product[genre_id]'
      fill_in 'product[product_name]', with: 'ケーキ'
      fill_in 'product[introduction]', with: 'いちごのショートケーキ'
      fill_in 'product[price]', with: '300'
      click_button type: 'submit'
    end
    
    context '必要事項を入力して登録ボタンを押下する'do
      
      it '登録した商品の詳細画面に遷移する' do
        expect(current_path).to eq '/admin/products/1'
      end
    end
    
    context 'ヘッダから商品一覧へのリンクを押下する' do
      before do
        find('.fa-cheese').click
      end
      
      it '商品一覧画面が表示される' do
        expect(current_path).to eq '/admin/products'
      end

      it '登録した商品が表示されている' do
        expect(page).to have_content 'ケーキ'
        expect(page).to have_content '300'
      end
    end
    
    context '新規登録ボタンを押下する(2商品目)' do
      before do
        visit admin_products_path
        find('.new-products').click
      end
      
      it '商品新規登録画面が表示される' do
        expect(current_path).to eq '/admin/products/new'
      end
    end

    context '必要事項を入力して登録ボタンを押下する'do
      let!(:genre) { create(:genre) }
      before do
        visit new_admin_product_path
        select 'ケーキ', from: 'product[genre_id]'
        fill_in 'product[product_name]', with: 'マフィン'
        fill_in 'product[introduction]', with: 'おいしい焼き菓子'
        fill_in 'product[price]', with: '500'
        click_button type: 'submit'
      end
      
      it '登録した商品の詳細画面に遷移する' do
        expect(current_path).to eq '/admin/products/2'
        expect(page).to have_content 'マフィン'
        expect(page).to have_content '500'
      end
    end
    
    context 'ヘッダから商品一覧へのリンクを押下する'do
      before do
        find('.fa-cheese').click
      end
      
      it '商品一覧画面が表示される' do
        expect(current_path).to eq '/admin/products'
      end
    end
  end
end