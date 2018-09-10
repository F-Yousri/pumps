require 'test_helper'

class PumpPropertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pump_property = pump_properties(:one)
  end

  test "should get index" do
    get pump_properties_url
    assert_response :success
  end

  test "should get new" do
    get new_pump_property_url
    assert_response :success
  end

  test "should create pump_property" do
    assert_difference('PumpProperty.count') do
      post pump_properties_url, params: { pump_property: {  } }
    end

    assert_redirected_to pump_property_url(PumpProperty.last)
  end

  test "should show pump_property" do
    get pump_property_url(@pump_property)
    assert_response :success
  end

  test "should get edit" do
    get edit_pump_property_url(@pump_property)
    assert_response :success
  end

  test "should update pump_property" do
    patch pump_property_url(@pump_property), params: { pump_property: {  } }
    assert_redirected_to pump_property_url(@pump_property)
  end

  test "should destroy pump_property" do
    assert_difference('PumpProperty.count', -1) do
      delete pump_property_url(@pump_property)
    end

    assert_redirected_to pump_properties_url
  end
end
