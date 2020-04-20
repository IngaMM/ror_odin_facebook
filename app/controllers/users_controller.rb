class UsersController < ApplicationController
  before_action :logged_in_user

  def index
    @users = User.paginate(page: params[:page], per_page: 15)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
    @photos = @user.photos.paginate(page: params[:page], per_page: 10)
  end

  private

  # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless user_signed_in?
        flash[:alert] = "Please log in."
        redirect_to new_user_session_path
      end
    end

end
