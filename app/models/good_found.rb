class GoodFound < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :execution_date
    validates :title
    validates :event_detail
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
    end
  end
end
