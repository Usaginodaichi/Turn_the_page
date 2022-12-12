require "test_helper"

class Public::ListsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_lists_new_url
    assert_response :success
  end
end
