require "application_system_test_case"

class PumpsTest < ApplicationSystemTestCase
  setup do
    @pump = pumps(:one)
  end

  test "visiting the index" do
    visit pumps_url
    assert_selector "h1", text: "Pumps"
  end

  test "creating a Pump" do
    visit pumps_url
    click_on "New Pump"

    click_on "Create Pump"

    assert_text "Pump was successfully created"
    click_on "Back"
  end

  test "updating a Pump" do
    visit pumps_url
    click_on "Edit", match: :first

    click_on "Update Pump"

    assert_text "Pump was successfully updated"
    click_on "Back"
  end

  test "destroying a Pump" do
    visit pumps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pump was successfully destroyed"
  end
end
