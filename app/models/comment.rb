class Comment < ApplicationRecord
  belongs_to :good_found
  belongs_to :user
  
end
