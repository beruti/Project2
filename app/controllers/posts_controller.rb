class PostsController < ApplicationController
  
  def index
    unless logged_in?
     redirect_to "/sessions/new"
    end 
    @posts= Post.all
    #ordering by most likes
    @posts = @posts.sort_by{ |post| post.likes.count }.reverse!
  end

  def new
    @post = Post.new
  end

  def edit
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
    redirect_to "/users/#{current_user.id}/home"

  end

  def update
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
      puts "/users/#{current_user.id}/home"

      @post = Post.find(params[:id])

      # destroy the database row
      @post.destroy
      # but this has not deleted all relative dependencies - so now users/home is broken

      #redirect
      redirect_to "/users/#{current_user.id}/home"
  end  

  def like_post

    if Post.find(params[:id]).likes.where(user_id: current_user.id).length == 0 
  
      # Post.find(params[:id]).likes.create(user_id: current_user.id)
      current_user.likes.create(post_id: params[:id])
  
      redirect_to "/posts"
    else
      current_user.likes.where(post_id: params[:id]).destroy_all
  
      redirect_to "/posts"
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
    redirect_to "/posts/build", notice: 'Back to the drawing board!'
  end

  def build
    @posts = Post.all
  end

end

private
  def post_params
  params.require(:post).permit(:name, :description, :image)
end
