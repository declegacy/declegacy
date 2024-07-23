class PermittedContact < ApplicationRecord
  belongs_to :crypted_note
  validates :email, format: {with: Devise.email_regexp}

  def request_for_access!
    update!(
      decrypt_access_requested_at: Time.now,
      decrypt_access_granted_at: Time.now + auto_grant_decrypt_permission_in_x_days_after_the_request.days
    )

    CryptedNoteMailer.request_access_email(self).deliver_later
  end

  def reject_access!
    update!(
      decrypt_access_requested_at: nil,
      decrypt_access_granted_at: nil,
      decrypt_access_rejected_at: Time.now
    )
  end

  def can_decrypt?
    true if decrypt_access_granted_at && decrypt_access_granted_at < Time.now
  end

  def verified_password?
    verified_password_at
  end
end
