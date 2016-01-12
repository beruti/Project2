class Post < ActiveRecord::Base
	belongs_to :user
	# has_many :likes, through: :user
	has_many :likes
end
