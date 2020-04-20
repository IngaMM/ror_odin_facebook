class FriendshipsController < ApplicationController

  def create
    friendship = current_user.friendships.build(befriended_id: params[:befriended_id])
    if friendship.save
     flash[:notice] = "You have a new friend."
     redirect_to root_url
    else
      flash[:alert] = "Your friendship did not work out."
      redirect_to root_url
    end
  end

  def destroy
    Friendship.find(params[:id]).destroy
    flash[:notice] = "Friendship deleted"
    redirect_to root_url
  end

end
