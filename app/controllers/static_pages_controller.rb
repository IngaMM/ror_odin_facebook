class StaticPagesController < ApplicationController

  def home
    if user_signed_in?
      redirect_to user_path(current_user.id)
    else
      flash[:alert] = "Please log in."
      redirect_to new_user_session_path
  end
end

end
