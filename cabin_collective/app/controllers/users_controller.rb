class UsersController < ApplicationController
 
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    #binding.pry
    @user = User.new(user_params)
    if @user.save 
      redirect_to users_path
    else 
      render 'new'
    end
  end

  def show
  end


  def edit
  end

  def delete
  end

  def update
  end

  def home
    @currentUserPosts = User.find(current_user.id).posts.where(user_id: current_user.id)
    @currentUserLikes = Like.where(user_id: current_user.id)
  end

end


private
  def user_params
  params.require(:user).permit(:email, :password, :password_confirmation)
end