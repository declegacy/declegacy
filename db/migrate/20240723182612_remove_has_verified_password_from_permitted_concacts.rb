class RemoveHasVerifiedPasswordFromPermittedConcacts < ActiveRecord::Migration[7.0]
  def change
    remove_column :permitted_contacts, :has_verified_password
    add_column :permitted_contacts, :auto_grant_decrypt_permission_in_x_days_after_the_request, :integer, default: 180
    drop_table :crypted_note_parts
  end
end
