class FriendrequestsController < ApplicationController

  def create
    friendrequest = current_user.sent_friendrequests.build(receiver_id: params[:receiver_id])
    if friendrequest.save
     flash[:notice] = "You sent a new friend request."
     redirect_to root_url
    else
      flash[:alert] = "Your friend request failed."
      redirect_to root_url
    end
  end


end
