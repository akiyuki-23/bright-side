require 'rails_helper'

RSpec.describe "良かった出来事の投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @good_found_title = Faker::Lorem.sentence
    @good_found_event_detail = Faker::Lorem.paragraph
    @good_found_execution_date = Faker::Date.between(from: 1.year.ago, to: Date.current)
    @good_found_category_id = 2
  end
  context '良かった出来事が投稿できる時' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_on('ログイン')
      expect(current_path).to eq(root_path)
      # 新規投稿画面へのボタンがあることを確認する
      expect(page).to have_content('新規投稿')
      # 投稿ページへ遷移する
      visit new_good_found_path
      # フォームに情報を入力する
      fill_in 'good_found_execution_date', with: @good_found_execution_date
      fill_in 'good_found_title', with: @good_found_title
      fill_in 'good_found_event_detail', with: @good_found_event_detail
      select '家庭', from: 'good_found_category_id'
      # 送信するとGoodFoundモデルのカウントが１上がることを確認する
      expect { click_on('投稿する')}.to change { GoodFound.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容の投稿が存在することを確認する(title)
      expect(page).to have_content(@good_found_title)
      # トップページには先ほど投稿した内容の投稿が存在することを確認する(execution_date)
      expect(page).to have_content(@good_found_execution_date)
    end
  end
  context '良かった出来事が投稿できない時' do
    it 'ログインしてないユーザーは新規投稿ページへ遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿画面へのボタンがないことを確認する
      expect(page).to have_no_content('新規投稿')
    end
  end
end

RSpec.describe "出来事の編集", type: :system do
  before do
    @good_found1 = FactoryBot.create(:good_found)
    @good_found2 = FactoryBot.create(:good_found)
  end
  context '出来事の編集ができる時' do
    it 'ログインしたユーザーは自身が投稿した出来事の編集ができる' do
      # good_found1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @good_found1.user.email
      fill_in 'user[password]', with: @good_found1.user.password
      click_on('ログイン')
      expect(current_path).to eq(root_path)
      # good_found1の詳細ページに遷移する
      visit good_found_path(@good_found1)
      # good_found1に編集リンクがある事を確認する
      expect(page).to have_link '編集する', href: edit_good_found_path(@good_found1)
      # 編集ページへ遷移する
      visit edit_good_found_path(@good_found1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#good_found_execution_date').value
      ).to eq(@good_found1.execution_date.strftime('%Y-%m-%d'))
      expect(
        find('#good_found_title').value
      ).to eq(@good_found1.title)
      expect(
        find('#good_found_event_detail').value
      ).to eq(@good_found1.event_detail)
      expect(
        find('#good_found_category_id.form-select').value.to_i
      ).to eq(@good_found1.category_id)
      # 投稿内容を編集する
      fill_in 'good_found_execution_date', with: "002020-10-06"
      fill_in 'good_found_title', with: "#{@good_found_title}+編集したテキスト"
      fill_in 'good_found_event_detail', with: "#{@good_found_event_detail}+編集したテキスト"
      select '仕事', from: 'good_found_category_id'
      # 編集してもGoodFoundモデルのカウントは変わらないことを確認する
      expect { click_on('更新する')}.to change { GoodFound.count }.by(0)
      # 詳細画面へ遷移する
      expect(current_path).to eq(good_found_path(@good_found1))
      # トップページには先ほど編集した内容の出来事が存在する事を確認する(タイトル)
      expect(page).to have_content("#{@good_found_title}+編集したテキスト")
      # トップページには先ほど編集した内容の出来事が存在する事を確認する(日付)
      expect(page).to have_content("2020/10/06")
    end
  end
  context '出来事の編集ができない時' do
    it 'ログインしたユーザーは自分以外が投稿した出来事の編集ができない' do
      # good_found1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @good_found1.user.email
      fill_in 'user[password]', with: @good_found1.user.password
      click_on('ログイン')
      expect(current_path).to eq(root_path)
      # good_found2に編集へのリンクがないことを確認する
      expect(page).to have_no_link '編集する', href: edit_good_found_path(@good_found1)
    end
    it 'ログインしていないと編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # good_found1に「編集」リンクがないことを確認する
      expect(page).to have_no_link '編集する', href: edit_good_found_path(@good_found1)
      # good_found2に「編集」リンクがないことを確認する
      expect(page).to have_no_link '編集する', href: edit_good_found_path(@good_found2)
    end
  end
end

