require 'rails_helper'

RSpec.describe "permitted_contacts/index", type: :view do
  before(:each) do
    assign(:permitted_contacts, [
      PermittedContact.create!(
        crypted_note: nil,
        email: "Email"
      ),
      PermittedContact.create!(
        crypted_note: nil,
        email: "Email"
      )
    ])
  end

  it "renders a list of permitted_contacts" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
  end
end
