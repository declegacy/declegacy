class CreateCryptedNoteParts < ActiveRecord::Migration[7.0]
  def change
    create_table :crypted_note_parts do |t|
      t.references :crypted_note_part
      t.text :crypted_content
      t.integer :part_index
      t.string :owner_email

      t.timestamps
    end
  end
end
