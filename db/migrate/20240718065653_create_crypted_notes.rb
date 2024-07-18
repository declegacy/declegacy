class CreateCryptedNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :crypted_notes do |t|
      t.references :user
      t.text :description
      t.text :crypted_content
      t.timestamps
    end
  end
end
