class PostsController < ApplicationController

  def index
    @posts = current_user.post_timeline.paginate(page: params[:page], per_page: 10)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def edit
    @post = Post.find(params[:post_id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post created!"
      redirect_to root_url
    else
      render 'posts/new'
    end
  end


  def update
    @post = Post.find(params[:id])
   if @post.update(post_params)
     flash[:notice] = 'Post updated!'
       redirect_to root_url
   else
       render 'posts/edit'
   end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post deleted!"
    redirect_back(fallback_location: root_path)
  end

  private

    def post_params
      params.require(:post).permit(:content, :picture)
    end
end
