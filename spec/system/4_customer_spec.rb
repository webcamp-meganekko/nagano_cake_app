require 'rails_helper'

describe '登録情報変更〜退会のテスト' do
    let!(:genre1) { create(:genre) }
    let!(:product1) { create(:product) }
    let!(:admin) { create(:admin) }
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

  describe 'マイページ編集のテスト'do
    context 'マイページへ遷移' do
      before do
        visit customer_show_path
      end
      it 'editボタンを押すと会員情報編集画面に遷移する'do#1
         find('a[href="/my_page/edit"]').click
        expect(current_path).to eq '/my_page/edit'
      end
    end

    context 'マイページ編集'do
      before do
        visit '/my_page/edit'
      end

      it '全項目を変更し、保存ボタンを押す'do#2,3
        fill_in 'customer[last_name]', with: "めがねっ"
        fill_in 'customer[first_name]', with: "こ"
        fill_in 'customer[last_name_kana]', with: "メガネッ"
        fill_in 'customer[first_name_kana]', with: "コ"
        fill_in 'customer[email]', with: "meganekko@megane.com"
        fill_in 'customer[postal_code]', with: "2223333"
        fill_in 'customer[address]', with: "東京都渋谷区"
        fill_in 'customer[tell]', with: "00987654321"
        find(".btn").click
        expect(current_path).to eq customer_show_path
        expect(page).to have_content "めがねっこ"
        expect(page).to have_content "メガネッコ"
        expect(page).to have_content "meganekko@megane.com"
        expect(page).to have_content "2223333"
        expect(page).to have_content "東京都渋谷区"
        expect(page).to have_content "00987654321"
      end
    end
  end
  describe '配送先のテスト'do
    before do
      visit customer_show_path
    end
    it '配送先一覧に遷移する'do#4
      find('a[href="/orders"]').click
      expect(current_path).to eq orders_path
    end
  end
  describe '配送先一覧画面のテスト'do
    before do
    visit addresses_path
    end
    it '配送先一覧で配達先が登録できているか'do#5
      fill_in 'address[postal_code]', with: "7778888"
      fill_in 'address[street_address]', with: "千葉県"
      fill_in 'address[receve_name]', with: "メガネッ子"
      find('.btn').click
      expect(current_path).to eq addresses_path
      expect(page).to have_content "7778888"#6
      expect(page).to have_content "千葉県"
      expect(page).to have_content "メガネッ子"
    end
    it 'ヘッダーからトップ画面へのリンクをクリックする'do#7
        find(".btnshine").click
        expect(current_path).to eq root_path
    end
  end
  describe '注文をする' do
     before do
      visit addresses_path
      fill_in 'address[postal_code]', with: "7778888"
      fill_in 'address[street_address]', with: "千葉県"
      fill_in 'address[receve_name]', with: "メガネッ子"
      find('.btn').click
      visit root_path
    end
    context '購入確認まで' do
      it 'トップページから商品詳細へ' do#8
        find('a[href="/products/1"]').click
        expect(current_path).to eq "/products/1"
        expect(page).to have_content product1.product_name#9
      end
      context '個数を選択してカートに入れる'do
        before do
          visit "products/1"
        end
          it '個数を選択する'do
            find("option[value='3']").select_option
            find('.btn').click
            expect(current_path).to eq carts_path#10
            expect(page).to have_content product1.product_name#11
            expect(page).to have_content product1.tax_included_price
        end
        context '注文する'do
          before do
            find("option[value='3']").select_option
            find('.btn').click
          end
          it 'お届け先入力'do
            find('a[href="/orders/new"]').click
            expect(current_path).to eq "/orders/new"#12
            choose "order_payment_method_銀行振込"
            # choose "order_address_option_0"#13
            choose "order_address_option_1"#13
            expect(page).to have_content "7778888"
            expect(page).to have_content "千葉県"
            expect(page).to have_content "メガネッ子"
            expect(page).to have_content "〒7778888　千葉県　メガネッ子"


            # find("#order_address_id").select("1", from: 'order[address_id]')

            select("〒7778888　千葉県　メガネッ子", from: 'order[address_id]')


            find('.btn').click
            expect(current_path).to eq '/orders/confirm'
            expect(page).to have_content product1.product_name
            # expect(page).to have_content "7778888"
            # expect(page).to have_content "千葉県"
            # expect(page).to have_content "メガネッ子"
            find('.btn').click
            expect(current_path).to eq '/orders/complete'

            find(".btnshine").click
            expect(current_path).to eq root_path#15

            find(".fa-user").click
            expect(current_path).to eq "/customers/my_page"#16

            find('a[href="/orders"]').click
            expect(current_path).to eq orders_path#17
            expect(page).to have_content product1.product_name
            # expect(page).to have_content order1.receve_name
            # expect(page).to have_content "メガネッ子"
            #18

            find(".fa-user").click
            expect(current_path).to eq "/customers/my_page"#19

          end
        end
      end
    end
  end
  describe "退会のテスト"do
    before do
      visit "products/1"
      find("option[value='3']").select_option
      find('.btn').click
      find('a[href="/orders/new"]').click
      choose "order_address_option_0"#13
      # choose "order_address_option_1"#13
      # find(".select").find("address_option[address_id='1']").select_option
      # find('.select').select('メガネッ子', from: 'current_customer_address[receve_name]')
      # find('.selecter').select('メガネッ子', from: 'address[receve_name]')
      find('.btn').click
      find('.btn').click
      find(".btnshine").click
      find(".fa-user").click
      find('a[href="/orders"]').click
      find(".fa-user").click
    end
    it"退会する"do
      find('a[href="/my_page/edit"]').click
      expect(current_path).to eq "/my_page/edit"#20

      find('a[href="/customers/quit_confirm"]').click
      expect(current_path).to eq "/customers/quit_confirm"
      find('a[href="/customers/quit"]').click

      # expect(page).to have_content '本当に退会してもよろしいですか？'
      # page.driver.browser.switch_to.alert.accept
      expect(current_path).to eq "/customers/quit"#21

      find('.btn').click
      expect(current_path).to eq "/" #22
    end

    context'退会確認'do
      before do
         find(".fa-user").click
         find('a[href="/my_page/edit"]').click
         find('a[href="/customers/quit_confirm"]').click
         find('a[href="/customers/quit"]').click
      end

      it "ログインできないか確認のテスト"do
        find('.fa-info-circle')#23

        find('.fa-sign-in-alt').click
        expect(current_path).to eq "/customers/sign_in" #24

        fill_in 'customer[email]', with: "sample@test.com"
        fill_in 'customer[password]', with: "password"
        find(".btn").click
        expect(current_path).to eq "/customers/sign_in" #25
      end

      context "管理者側でのテスト"do
        before do
          visit new_admin_session_path
          fill_in 'admin[email]', with: 'test@test.com'
          fill_in 'admin[password]', with:  'aaaaaa'
          find(".btn").click
        end

        it "アドレスとパスワードでログインできるか"do
          expect(current_path).to eq "/admin" #26
        end

        it"登録customerの退会確認のテスト"do
          find(".fa-users").click
          expect(current_path).to eq "/admin/customers"#27
          expect(page).to have_content "令和道子"
          expect(page).to have_content "sample@test.com"
          expect(page).to have_content "退会"#28
          find(".customer").click
          expect(current_path).to eq "/admin/customers/1" #29
          # expect(page).to have_content "千葉県"#30
        end
        it"ヘッダーからログアウトのテスト"do
          find('.fa-sign-out-alt').click
          expect(current_path).to eq "/admins/sign_in"#31
        end
      end
    end
  end
end