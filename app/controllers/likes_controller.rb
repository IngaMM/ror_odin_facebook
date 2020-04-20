class LikesController < ApplicationController
  before_action :load_likable

  def create
    like = @likable.likes.build
    like.save
    redirect_back fallback_location: '/'
  end

  private

  def load_likable
    if params.has_key?(:post_id)
      resource = "post"
      id = params[:post_id]
    elsif params.has_key?(:photo_id)
      resource = "photo"
      id = params[:photo_id]
    end
    @likable = resource.singularize.classify.constantize.find(id)
  end

end
