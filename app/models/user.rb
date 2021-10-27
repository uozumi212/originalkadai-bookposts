class User < ApplicationRecord
    validates :name, presence: true, length: { maximum: 20 }
     validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :bookposts, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :likings, through: :likes, source: :bookpost
    
    
    def like(other_bookpost)
        unless self == other_bookpost
        self.likes.find_or_create_by(bookpost_id: other_bookpost.id)
        end
    end
    
    def unlike(other_bookpost)
        like = self.likes.find_by(bookpost_id: other_bookpost.id)
        like.destroy if like
    end
    
    def liking?(other_bookpost)
        self.likings.include?(other_bookpost)
    end
    
    def feed_bookposts
     Bookpost.where(user_id: self.liking_ids + [self.id])
    end
end
