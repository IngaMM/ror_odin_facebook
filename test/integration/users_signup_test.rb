require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'devise/registrations/new'
    assert_select 'div#error_explanation'
  end

  test "valid signup information" do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { email: "testuser@valid.com",
                                         password:              "foobar",
                                         password_confirmation: "foobar" } }
    end
    assert_redirected_to root_path
    assert_not flash.empty?
  end
end
