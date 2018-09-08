require "application_system_test_case"

class DecisionMatricesTest < ApplicationSystemTestCase
  setup do
    @decision_matrix = decision_matrices(:one)
  end

  test "visiting the index" do
    visit decision_matrices_url
    assert_selector "h1", text: "Decision Matrices"
  end

  test "creating a Decision matrix" do
    visit decision_matrices_url
    click_on "New Decision Matrix"

    click_on "Create Decision matrix"

    assert_text "Decision matrix was successfully created"
    click_on "Back"
  end

  test "updating a Decision matrix" do
    visit decision_matrices_url
    click_on "Edit", match: :first

    click_on "Update Decision matrix"

    assert_text "Decision matrix was successfully updated"
    click_on "Back"
  end

  test "destroying a Decision matrix" do
    visit decision_matrices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Decision matrix was successfully destroyed"
  end
end
