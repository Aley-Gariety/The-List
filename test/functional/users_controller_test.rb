require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { bad_karma: @user.bad_karma, creation: @user.creation, email: @user.email, full_name: @user.full_name, good_karma: @user.good_karma, influence: @user.influence, last_login: @user.last_login, password: @user.password, saved: @user.saved, site: @user.site, username: @user.username }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { bad_karma: @user.bad_karma, creation: @user.creation, email: @user.email, full_name: @user.full_name, good_karma: @user.good_karma, influence: @user.influence, last_login: @user.last_login, password: @user.password, saved: @user.saved, site: @user.site, username: @user.username }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end
