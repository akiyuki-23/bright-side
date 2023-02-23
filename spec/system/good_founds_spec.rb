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
