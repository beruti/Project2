class PostsController < ApplicationController
  
  def index

    unless logged_in?
     redirect_to "/sessions/new"
    end 
    # IS BREAKING SITE even when user logged in 
    @posts= Post.all
  end

  def new
    @post = Post.new
  end

  def edit
    #bring up the selected post when button clicked
    # make form in views
    @post = Post.find(params[:id])

  end

  def show
    # route already in place by resources 
    #   post GET    /posts/:id(.:format)          posts#show
  end

  def create

    #sanitize the routes ( only allow certain fields )
    sanitized = params.require(:post).permit(:name, :description , :image)

    # create a new post object with the params from the request
    #post = Post.new(sanitized);
    post = current_user.posts.create(sanitized);

    #save file to database
    post.save 
    
    #redirect
    redirect_to action: "index"

  end

  def update
    #what do you want to do to the post
    #all changes are made by user - this is stored in params in page before clickthrough
    #sanitize the routes ( only allow certain fields )
    sanitized = params.require(:post).permit(:name, :description , :image)

    # create a new post object with the params from the request
    #post = Post.new(sanitized);
    post = current_user.posts.create(sanitized);

    #save file to database
    post.update 
    
    #redirect
    redirect_to action: "index"
  end

  def destroy
      @post = Post.find(params[:id])

      # destroy the database row
      @post.destroy 
      # but this has not deleted all relative dependencies - so now users/home is broken

      #redirect
      redirect_to '/users/home'
  end  

  def like_post
    Post.find(params[:id]).likes.create(user_id: current_user.id)

    redirect_to "/posts"
    # need css/whatever trick that means you stay at same point on page
    # need to limit number of likes per post to one per user - validation!
  end
  
end
