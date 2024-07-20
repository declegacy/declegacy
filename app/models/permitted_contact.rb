class PermittedContact < ApplicationRecord
  belongs_to :crypted_note
  validates :email, format: {with: Devise.email_regexp}
end
