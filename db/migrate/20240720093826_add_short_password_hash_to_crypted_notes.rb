class AddShortPasswordHashToCryptedNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :crypted_notes, :short_password_hash, :string
  end
end
