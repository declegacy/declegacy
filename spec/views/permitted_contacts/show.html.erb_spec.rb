require 'rails_helper'

RSpec.describe "permitted_contacts/show", type: :view do
  before(:each) do
    assign(:permitted_contact, PermittedContact.create!(
      crypted_note: nil,
      email: "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Email/)
  end
end
