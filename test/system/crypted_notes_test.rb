require "application_system_test_case"

class CryptedNotesTest < ApplicationSystemTestCase
  setup do
    @crypted_note = crypted_notes(:one)
  end

  test "visiting the index" do
    visit crypted_notes_url
    assert_selector "h1", text: "Crypted notes"
  end

  test "should create crypted note" do
    visit crypted_notes_url
    click_on "New crypted note"

    click_on "Create Crypted note"

    assert_text "Crypted note was successfully created"
    click_on "Back"
  end

  test "should update Crypted note" do
    visit crypted_note_url(@crypted_note)
    click_on "Edit this crypted note", match: :first

    click_on "Update Crypted note"

    assert_text "Crypted note was successfully updated"
    click_on "Back"
  end

  test "should destroy Crypted note" do
    visit crypted_note_url(@crypted_note)
    click_on "Destroy this crypted note", match: :first

    assert_text "Crypted note was successfully destroyed"
  end
end
