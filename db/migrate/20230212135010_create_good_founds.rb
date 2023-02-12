class CreateGoodFounds < ActiveRecord::Migration[6.1]
  def change
    create_table :good_founds do |t|
      t.date       :execution_date, null: false
      t.string     :title,          null: false
      t.text       :event_detail,   null: false
      t.integer    :event_category, null: false
      t.references :user,           null: false, foreign_key: true
      t.timestamps
    end
  end
end
