class CommentsController < ApplicationController
  before_action :load_commentable

  def new
    @comment = current_user.comments.build
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "Comment added!"
      redirect_to @commentable
    else
      render 'comments/new'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :commentable_id, :commentable_type)
    end

    def load_commentable
      if params.has_key?(:post_id)
        resource = "post"
        id = params[:post_id]
      elsif params.has_key?(:photo_id)
        resource = "photo"
        id = params[:photo_id]
      else
        id = params[:comment][:commentable_id]
        resource = params[:comment][:commentable_type]
      end
      @commentable = resource.singularize.classify.constantize.find(id)
    end
end
