require 'test_helper'

class AirvmsControllerTest < ActionController::TestCase
  setup do
    @airvm = airvms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:airvms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create airvm" do
    assert_difference('Airvm.count') do
      post :create, airvm: { encrypted_password: @airvm.encrypted_password, encrypted_user: @airvm.encrypted_user, host: @airvm.host }
    end

    assert_redirected_to airvm_path(assigns(:airvm))
  end

  test "should show airvm" do
    get :show, id: @airvm
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @airvm
    assert_response :success
  end

  test "should update airvm" do
    patch :update, id: @airvm, airvm: { encrypted_password: @airvm.encrypted_password, encrypted_user: @airvm.encrypted_user, host: @airvm.host }
    assert_redirected_to airvm_path(assigns(:airvm))
  end

  test "should destroy airvm" do
    assert_difference('Airvm.count', -1) do
      delete :destroy, id: @airvm
    end

    assert_redirected_to airvms_path
  end
end
