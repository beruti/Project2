class PostsController < ApplicationController
  
  def index

    unless logged_in?
     redirect_to "/sessions/new"
    end 
    # IS BREAKING SITE even when user logged in 
    @posts= Post.all
    @posts = @posts.sort_by{ |post| post.likes.count }.reverse!

    # What association are you trying to draw out?
    # I am trying to print the user id of whoever liked the post to the page
    # WHY?
    # Doing so in order to identify the row in the like table so I can remove this specific one 

  end

  def new
    @post = Post.new
  end

  def edit
    #bring up the selected post when button clicked
    #make form in views
    @post = Post.find(params[:id])

  end

  def show
    # route already in place by resources 
    #   post GET    /posts/:id(.:format)          posts#show
    @post = Post.find(params[:id])
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
    puts params
      @post = Post.find(params[:id])

      # destroy the database row
      @post.destroy 
      # but this has not deleted all relative dependencies - so now users/home is broken

      #redirect
      redirect_to '/users/#{current_user.id}/home'
  end  

  def like_post

    if Post.find(params[:id]).likes.where(user_id: current_user.id).length == 0 
  
      # Post.find(params[:id]).likes.create(user_id: current_user.id)
      current_user.likes.create(post_id: params[:id])
  
      redirect_to "/posts"
    else

      current_user.likes.where(post_id: params[:id]).destroy_all

      # Post.find(params[:id]).likes.delete(user_id: current_user.id, post_id: params[:id])
      # destroy breaks it
  
      redirect_to "/posts"
      # need css/whatever trick that means you stay at same point on page
      # need to limit number of likes per post to one per user - validation!
    end
  end
  
  def archived
    @post = Post.find(params[:id])
    @post.update(archived: true)
    redirect_to "/posts/build", notice: 'Build This Thing!' 
  end

  def unarchived
    @post = Post.find(params[:id])
    @post.update(archived: false)
    redirect_to "/posts", notice: 'Back to the drawing board!'
  end

  def build
    @posts = Post.all
  end

end

private
  def post_params
  params.require(:post).permit(:name, :description, :image)
end
