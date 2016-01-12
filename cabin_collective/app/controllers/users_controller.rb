class UsersController < ApplicationController
  def index
    unless logged_in?
      redirect_to "/sessions/new"
    end 

    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    #binding.pry
    @user = User.new(user_params)

    if @user.save 
    
    redirect_to "/posts"
    else 
      render 'new'
    end
  end

  def show
  end


  def edit
  end

  def destroy

    @user = User.find(params[:id])

    # destroy the database row
    @user.destroy

    #redirect
    redirect_to action: 'index'
    
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