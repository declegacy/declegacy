class RemoveRequireApprovalToDecryptContentFromPermittedContacts < ActiveRecord::Migration[7.0]
  def change
    remove_column :permitted_contacts, :require_approval_to_decrypt_content, :boolean
  end
end
