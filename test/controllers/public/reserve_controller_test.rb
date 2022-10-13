require "test_helper"

class Public::ReserveControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_reserve_new_url
    assert_response :success
  end

  test "should get confirm" do
    get public_reserve_confirm_url
    assert_response :success
  end

  test "should get complete" do
    get public_reserve_complete_url
    assert_response :success
  end
end
