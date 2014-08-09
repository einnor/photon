require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get dashboard" do
    get :dashboard
    assert_response :success
  end

  test "should get contact-us" do
    get :contact-us
    assert_response :success
  end

  test "should get about-us" do
    get :about-us
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

end
