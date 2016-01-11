class Like < ActiveRecord::Base
	belongs_to :post
	validates :user_id, presence: true, uniqueness: true, default: current_user.id
	# attribute :user_id, :integer, default: session[:user_id] 
end

# so what is happening in the database when the post receives a like?

# a like id is inserted into to the post column - what information does this like have with it?
