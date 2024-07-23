class CryptedNoteMailer < ApplicationMailer
  def request_access_email(permitted_contact)
    @crypted_note = permitted_contact.crypted_note
    @permitted_contact = permitted_contact

    mail(to: @crypted_note.user.email, subject: "Access to crypted note has been requested from #{@permitted_contact.email}")
  end

  def grant_permission_email(permitted_contact)
    @crypted_note = permitted_contact.crypted_note
    @permitted_contact = permitted_contact

    mail(to: @permitted_contact.email, subject: "You have been selected as trusted person for #{@crypted_note.user.email}")
  end
end
