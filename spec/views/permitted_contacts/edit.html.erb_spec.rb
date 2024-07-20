require 'rails_helper'

RSpec.describe "permitted_contacts/edit", type: :view do
  let(:permitted_contact) {
    PermittedContact.create!(
      crypted_note: nil,
      email: "MyString"
    )
  }

  before(:each) do
    assign(:permitted_contact, permitted_contact)
  end

  it "renders the edit permitted_contact form" do
    render

    assert_select "form[action=?][method=?]", permitted_contact_path(permitted_contact), "post" do

      assert_select "input[name=?]", "permitted_contact[crypted_note_id]"

      assert_select "input[name=?]", "permitted_contact[email]"
    end
  end
end
