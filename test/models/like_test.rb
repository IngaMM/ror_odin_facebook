require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @post = posts(:orange)
    @like = @post.likes.build
  end

  test "should be valid" do
    assert @like.valid?
  end

  test "likable id should be present" do
    @like.likable_id = nil
    assert_not @like.valid?
  end
end
