class User < ActiveRecord::Base
	has_many :posts 
	has_many :likes
	has_many :liked, -> { distinct },  through: "likes", source: :post
	has_secure_password
	validates :email, presence: true, uniqueness: true 

end
