class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user
 
  def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  helper_method :has_liked?

  def has_liked?(post)
    if post.likes.where(user_id: current_user.id).length == 0 
      return 'like'
    else
      return 'unlike'
    end

  end

 helper_method :pluralize_without_count

 def pluralize_without_count(count)
   if count == 1 
     'like'
   else
     'likes'
   end
 end

  def logged_in?
  	!!current_user
  end

  def authenticate
  	unless logged_in?
  		flash[:error] = "You must be logged in to access this section of the site"
  		redirect_to login_url
  	end
  end
end


 