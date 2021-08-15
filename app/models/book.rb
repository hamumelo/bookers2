class Book < ApplicationRecord
 
 belongs_to :user
 attachment :image
 
  validates :title, presence: true
  validates :body, length: {maximum: 200}, presence: true
  
end
