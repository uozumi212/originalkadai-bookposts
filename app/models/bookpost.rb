class Bookpost < ApplicationRecord
  belongs_to :user
  
   validates :content, presence: true, length: { maximum: 200 }
    validates :title, presence: true, length: { maximum: 30 }
    
    has_many :likes, dependent: :destroy
end
