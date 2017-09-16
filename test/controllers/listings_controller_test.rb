require 'test_helper'

class ListingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get listings_new_url
    assert_response :success
  end

end
