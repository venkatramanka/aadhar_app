require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get signup" do
    get :signup
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
