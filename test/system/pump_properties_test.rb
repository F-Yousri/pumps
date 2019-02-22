require "application_system_test_case"

class PumpPropertiesTest < ApplicationSystemTestCase
  setup do
    @pump_property = pump_properties(:one)
  end

  test "visiting the index" do
    visit pump_properties_url
    assert_selector "h1", text: "Pump Properties"
  end

  test "creating a Pump property" do
    visit pump_properties_url
    click_on "New Pump Property"

    click_on "Create Pump property"

    assert_text "Pump property was successfully created"
    click_on "Back"
  end

  test "updating a Pump property" do
    visit pump_properties_url
    click_on "Edit", match: :first

    click_on "Update Pump property"

    assert_text "Pump property was successfully updated"
    click_on "Back"
  end

  test "destroying a Pump property" do
    visit pump_properties_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pump property was successfully destroyed"
  end
end
