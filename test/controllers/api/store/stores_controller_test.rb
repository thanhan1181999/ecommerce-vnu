require 'test_helper'

class Api::Store::StoresControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_store_stores_create_url
    assert_response :success
  end

  test "should get delete" do
    get api_store_stores_delete_url
    assert_response :success
  end

end
