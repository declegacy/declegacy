class CryptedNote < ApplicationRecord
  belongs_to :user
  has_many :crypted_note_parts
  has_many :permitted_contacts

  validates :description, :crypted_content, presence: true
end
