require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @user = users(:testuser)
    @post = posts(:tau_manifesto)
    @comment1 = @user.comments.build(commentable_id: @post.id, commentable_type: "Post", content: "Good post!")
    @comment2 = @post.comments.build(user_id: @user.id, commentable_type: "Post", content: "I disagree!")
  end

  test "should be valid" do
    assert @comment1.valid?
    assert @comment2.valid?
  end

  test "user id should be present" do
    @comment1.user_id = nil
    assert_not @comment1.valid?
  end

  test "commentable id should be present" do
    @comment1.commentable_id = nil
    assert_not @comment1.valid?
  end

  test "content should be present" do
    @comment1.content = "   "
    assert_not @comment1.valid?
  end

  test "content should be at most 140 characters" do
    @comment1.content = "a" * 141
    assert_not @comment1.valid?
  end



end
