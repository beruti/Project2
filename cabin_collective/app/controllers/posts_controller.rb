class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def edit
  end

  def show
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
  end

  def delete
  end

  def index
    @posts= Post.all
  end

  def like_post
    Post.find(params[:id]).likes.create(user_id: current_user.id)

    redirect_to "/posts/#{params[:id]}"
  end

  
  
end
