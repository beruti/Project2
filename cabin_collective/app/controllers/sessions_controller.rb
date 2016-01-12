class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
      session[:user_id] = user.id
  		redirect_to "/posts", notice: "logged in!"
  	else
  		flash.now.alert	= "invalid login credentials"
  		render 'new'
  	end 
  end

  def destroy
    puts params
    session[:user_id] = nil
  	redirect_to "/sessions/new", notice: "logged out!"  
  end


end
