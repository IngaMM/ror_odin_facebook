require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:testuser)
    @otheruser = users(:otheruser)
  end

  test "login with invalid information" do
   get new_user_session_path
   assert_template 'devise/sessions/new'
   post new_user_session_path, params: { session: { email: "", password: "" } }
   assert_template 'devise/sessions/new'
   assert_not flash.empty?
   get new_user_session_path
   assert_template 'devise/sessions/new'
   assert flash.empty?
 end

 test "login with valid information followed by logout" do
    get new_user_session_path
    sign_in @user
    # Testing the redirect directly does not seem to work with Devise
    get user_path(@user)
    assert_template 'users/show'
    assert_select "a[href=?]", new_user_session_path, count: 0
    assert_select "a[href=?]", destroy_user_session_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", new_post_path

    # Root is the user's homepage
    get root_path
    follow_redirect!
    assert_template 'users/show'

    # Test logout
    sign_out @user
    get user_path(@user)
    follow_redirect!
    assert_not flash.empty?
    assert_template 'devise/sessions/new'
    assert_select "a[href=?]", new_user_session_path
    assert_select "a[href=?]", destroy_user_session_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", new_post_path, count: 0
  end

  test "without login only the login page is visible" do
    get user_path(@user)
    follow_redirect!
    assert_not flash.empty?
    assert_template 'devise/sessions/new'

    get users_path
    follow_redirect!
    assert_not flash.empty?
    assert_template 'devise/sessions/new'

    get root_path
    follow_redirect!
    assert_not flash.empty?
    assert_template 'devise/sessions/new'
  end


end
