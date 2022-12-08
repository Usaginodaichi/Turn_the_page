require "test_helper"

class Public::TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_todos_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_todos_edit_url
    assert_response :success
  end
end
