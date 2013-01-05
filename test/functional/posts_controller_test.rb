require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { comment_count: @post.comment_count, downvote: @post.downvote, id: @post.id, text: @post.text, title: @post.title, upvote: @post.upvote, url: @post.url, user: @post.user }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    put :update, id: @post, post: { comment_count: @post.comment_count, downvote: @post.downvote, id: @post.id, text: @post.text, title: @post.title, upvote: @post.upvote, url: @post.url, user: @post.user }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end
