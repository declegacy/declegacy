class CryptedNote < ApplicationRecord
  belongs_to :user
  has_many :crypted_note_parts
  has_many :permitted_contacts

  validates :description, :crypted_content, presence: true

  def backup_code
    file_name = Rails.root.join(*%w[app views crypted_notes _executable_code.erb])
    File.read(file_name).gsub("{{encrypted_content}}", crypted_content)
  end
end
