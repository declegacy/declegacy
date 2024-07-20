class CreatePermittedContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :permitted_contacts do |t|
      t.references :crypted_note, null: false, foreign_key: true
      t.string :email
      t.boolean :has_verified_password, default: false
      t.boolean :require_approval_to_decrypt_content, default: true
      t.timestamps
    end
  end
end
