require "test_helper"

class CryptedNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @crypted_note = crypted_notes(:one)
  end

  test "should get index" do
    get crypted_notes_url
    assert_response :success
  end

  test "should get new" do
    get new_crypted_note_url
    assert_response :success
  end

  test "should create crypted_note" do
    assert_difference("CryptedNote.count") do
      post crypted_notes_url, params: { crypted_note: {  } }
    end

    assert_redirected_to crypted_note_url(CryptedNote.last)
  end

  test "should show crypted_note" do
    get crypted_note_url(@crypted_note)
    assert_response :success
  end

  test "should get edit" do
    get edit_crypted_note_url(@crypted_note)
    assert_response :success
  end

  test "should update crypted_note" do
    patch crypted_note_url(@crypted_note), params: { crypted_note: {  } }
    assert_redirected_to crypted_note_url(@crypted_note)
  end

  test "should destroy crypted_note" do
    assert_difference("CryptedNote.count", -1) do
      delete crypted_note_url(@crypted_note)
    end

    assert_redirected_to crypted_notes_url
  end
end
