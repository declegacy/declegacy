class AddVerifiedPasswordAtToPermittedContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :permitted_contacts, :verified_password_at, :datetime
  end
end
