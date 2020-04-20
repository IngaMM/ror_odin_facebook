class Friendship < ApplicationRecord
  after_create :create_inverse_friendship, :destroy_friendrequests
  after_destroy :destroy_inverse_friendship

  belongs_to :friend, class_name: "User"
  belongs_to :befriended, class_name: "User"
  validates :friend_id, presence: true
  validates :befriended_id, presence: true

  private

  def create_inverse_friendship
    friendship = befriended.friendships.find_by(befriended: friend)
    unless friendship
      friendship = befriended.friendships.build(befriended: friend)
      friendship.save
    end
  end

  def destroy_friendrequests
    friendrequest = friend.received_friendrequests.find_by(sender: befriended)
    friendrequest.destroy if friendrequest

    friendrequest = friend.sent_friendrequests.find_by(receiver: befriended)
    friendrequest.destroy if friendrequest
  end

  def destroy_inverse_friendship
    friendship = befriended.friendships.find_by(befriended: friend)
    friendship.destroy if friendship
  end

end
