class AddRequestedAccessAtToPermittedContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :permitted_contacts, :decrypt_access_requested_at, :datetime
    add_column :permitted_contacts, :decrypt_access_granted_at, :datetime
  end
end
