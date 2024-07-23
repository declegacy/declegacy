class AddEncryptedContentAccessedAtToPermittedContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :permitted_contacts, :encrypted_content_accessed_at, :datetime
  end
end
