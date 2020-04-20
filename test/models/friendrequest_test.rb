require 'test_helper'

class FriendrequestTest < ActiveSupport::TestCase

  def setup
    @friendrequest = Friendrequest.new(sender_id: users(:testuser).id,
                                     receiver_id: users(:otheruser).id)
  end

  test "should be valid" do
    assert @friendrequest.valid?
  end

  test "should require a receiver_id" do
    @friendrequest.receiver_id = nil
    assert_not @friendrequest.valid?
  end

  test "should require a sender_id" do
    @friendrequest.sender_id = nil
    assert_not @friendrequest.valid?
  end

end
