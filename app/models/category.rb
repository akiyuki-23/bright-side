class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' }, 
    { id: 2, name: '家庭' },
    { id: 3, name: '仕事' },
    { id: 4, name: '勉強' },
    { id: 1, name: '趣味' }
  ]

  include ActiveHash::Associations
  has_many :articles
  
end