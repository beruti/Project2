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
      session[:user_id] = @user.id
      redirect_to posts_path
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
    puts params[:current_user]
   @currentUserPosts = User.find(current_user.id).posts.where(user_id: current_user.id)
   @currentUserLikes = Like.where(user_id: current_user.id)
  end

end
    
private
  def user_params
  params.require(:user).permit(:email, :password, :password_confirmation)
end