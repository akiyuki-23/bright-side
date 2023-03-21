require 'rails_helper'

RSpec.describe GoodFound, type: :model do
  before do
    @good_found = FactoryBot.build(:good_found)
  end

  describe 'いい出来事の保存' do
    context "いい出来事が保存できる場合" do
      it "すべての項目が入力されていれば保存される" do
        expect(@good_found).to be_valid
      end
    end
    context "いい出来事が保存されない場合" do
      it "execution_dateが空では登録できない" do
        @good_found.execution_date = ''
        @good_found.valid?
        expect(@good_found.errors.full_messages).to include("日付を入力してください")
      end
      it "titleが空では登録できない" do
        @good_found.title = ''
        @good_found.valid?
        expect(@good_found.errors.full_messages).to include("タイトルを入力してください")
      end
      it "event_detailが空では登録できない" do
        @good_found.event_detail = ''
        @good_found.valid?
        expect(@good_found.errors.full_messages).to include("内容を入力してください")
      end
      it "category_idがid:1では登録できない" do
        @good_found.category_id = '1'
        @good_found.valid?
        expect(@good_found.errors.full_messages).to include("カテゴリーを入力してください
          ")
      end
    end
  end
end
