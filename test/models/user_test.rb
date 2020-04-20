require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "testuser@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = ""
    assert_not @user.valid?
  end

  test "password and password_confirmation should match" do
    @user.password_confirmation = "foo"
    assert_not @user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "can send out and receive a friend request and become friends" do
    testuser = users(:testuser)
    otheruser  = users(:otheruser)
    @friendrequest = testuser.sent_friendrequests.build(receiver: otheruser)
    @friendrequest.save
    testuser.sent_friendrequests.include?(@friendrequest)
    testuser.invited_users.include?(otheruser)
    otheruser.received_friendrequests.include?(@friendrequest)
    otheruser.inviting_users.include?(testuser)

    @friendship = otheruser.friendships.build(befriended: testuser)
    @friendship.save
    otheruser.friendships.include?(@friendship)
    otheruser.friends.include?(testuser)
    # inverse friendship is created as well
    testuser.friends.include?(otheruser)

    # friend request is deleted when friendship is saved
    testuser.sent_friendrequests.exclude?(@friendrequest)
    otheruser.received_friendrequests.exclude?(@friendrequest)
  end

  test "associated posts should be destroyed" do
    @user.save
    @user.posts.create!(content: "Lorem ipsum")
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end

  test "timeline should have the right posts" do
    testuser = users(:testuser)
    otheruser  = users(:otheruser)
    thirduser    = users(:thirduser)
    # Posts from befriended
    fs = testuser.friendships.build(befriended_id: otheruser.id)
    fs.save
    otheruser.posts.each do |post_friend|
      assert testuser.post_timeline.include?(post_friend)
    end
    # Posts from self
    testuser.posts.each do |post_self|
      assert testuser.post_timeline.include?(post_self)
    end
    # Posts from a user who is not a friend
    thirduser.posts.each do |post_not_friend|
      assert_not testuser.post_timeline.include?(post_not_friend)
    end
  end


end
