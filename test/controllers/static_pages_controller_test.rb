require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "redirect to login when not logged in" do
    get root_path
    assert_redirected_to new_user_session_path
    assert_not flash.empty?
  end
end
