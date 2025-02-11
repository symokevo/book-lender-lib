require "test_helper"

class BorrowingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get borrowings_index_url
    assert_response :success
  end
end
