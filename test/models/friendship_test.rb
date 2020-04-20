require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase

  def setup
    @friendship = Friendship.new(friend_id: users(:testuser).id,
                                     befriended_id: users(:otheruser).id)
  end

  test "should be valid" do
    assert @friendship.valid?
  end

  test "should require a friend_id" do
    @friendship.friend_id = nil
    assert_not @friendship.valid?
  end

  test "should require a befriended_id" do
    @friendship.befriended_id = nil
    assert_not @friendship.valid?
  end

end
