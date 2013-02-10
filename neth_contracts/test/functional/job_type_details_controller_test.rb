require 'test_helper'

class JobTypeDetailsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:job_type_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create job_type_detail" do
    assert_difference('JobTypeDetail.count') do
      post :create, :job_type_detail => { }
    end

    assert_redirected_to job_type_detail_path(assigns(:job_type_detail))
  end

  test "should show job_type_detail" do
    get :show, :id => job_type_details(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => job_type_details(:one).id
    assert_response :success
  end

  test "should update job_type_detail" do
    put :update, :id => job_type_details(:one).id, :job_type_detail => { }
    assert_redirected_to job_type_detail_path(assigns(:job_type_detail))
  end

  test "should destroy job_type_detail" do
    assert_difference('JobTypeDetail.count', -1) do
      delete :destroy, :id => job_type_details(:one).id
    end

    assert_redirected_to job_type_details_path
  end
end
