require 'rails_helper'

RSpec.describe "permitted_contacts/new", type: :view do
  before(:each) do
    assign(:permitted_contact, PermittedContact.new(
      crypted_note: nil,
      email: "MyString"
    ))
  end

  it "renders new permitted_contact form" do
    render

    assert_select "form[action=?][method=?]", permitted_contacts_path, "post" do

      assert_select "input[name=?]", "permitted_contact[crypted_note_id]"

      assert_select "input[name=?]", "permitted_contact[email]"
    end
  end
end
