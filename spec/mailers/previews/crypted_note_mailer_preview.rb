# Preview all emails at http://localhost:3000/rails/mailers/crypted_note_mailer
class CryptedNoteMailerPreview < ActionMailer::Preview
  def request_access_email
    CryptedNoteMailer.request_access_email(PermittedContact.last)
  end

  def grant_permission_email
    CryptedNoteMailer.grant_permission_email(PermittedContact.last)
  end

  def secret_backup_email
    CryptedNoteMailer.secret_backup_email(CryptedNote.last)
  end
end
