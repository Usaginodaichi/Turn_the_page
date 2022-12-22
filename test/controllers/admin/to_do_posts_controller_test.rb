require "test_helper"

class Admin::ToDoPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_to_do_posts_index_url
    assert_response :success
  end

  test "should get edit" do
    get admin_to_do_posts_edit_url
    assert_response :success
  end
end
