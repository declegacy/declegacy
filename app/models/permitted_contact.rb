class PermittedContact < ApplicationRecord
  belongs_to :crypted_note
  validates :email, format: {with: Devise.email_regexp}

  def request_for_access!
    update!(decrypt_access_requested_at: Time.now)
  end

  def reject_access!
    update!(decrypt_access_requested_at: nil, decrypt_access_rejected_at: Time.now)
  end

  def auto_approve_decrypt_access_at
    return nil unless decrypt_access_requested_at

    decrypt_access_requested_at + 1.month
  end
end
