class PhotosController < ApplicationController

  def index
    @photos = current_user.photo_timeline.paginate(page: params[:page], per_page: 10)
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = current_user.photos.build
  end

  def create
    if (!params[:photo])
      @photo = current_user.photos.build
      render 'photos/new'
    else
      @photo = current_user.photos.build(photo_params)
      if @photo.save
        flash[:notice] = "Photo uploaded!"
        redirect_to root_url
      else
        render 'photos/new'
      end
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    flash[:notice] = "Photo deleted!"
    redirect_back(fallback_location: root_path)
  end

  private

    def photo_params
      params.require(:photo).permit(:picture)
    end
end
