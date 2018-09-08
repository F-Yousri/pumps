require 'test_helper'

class DecisionMatricesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @decision_matrix = decision_matrices(:one)
  end

  test "should get index" do
    get decision_matrices_url
    assert_response :success
  end

  test "should get new" do
    get new_decision_matrix_url
    assert_response :success
  end

  test "should create decision_matrix" do
    assert_difference('DecisionMatrix.count') do
      post decision_matrices_url, params: { decision_matrix: {  } }
    end

    assert_redirected_to decision_matrix_url(DecisionMatrix.last)
  end

  test "should show decision_matrix" do
    get decision_matrix_url(@decision_matrix)
    assert_response :success
  end

  test "should get edit" do
    get edit_decision_matrix_url(@decision_matrix)
    assert_response :success
  end

  test "should update decision_matrix" do
    patch decision_matrix_url(@decision_matrix), params: { decision_matrix: {  } }
    assert_redirected_to decision_matrix_url(@decision_matrix)
  end

  test "should destroy decision_matrix" do
    assert_difference('DecisionMatrix.count', -1) do
      delete decision_matrix_url(@decision_matrix)
    end

    assert_redirected_to decision_matrices_url
  end
end
