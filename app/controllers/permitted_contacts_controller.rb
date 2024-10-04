class PermittedContactsController < ApplicationController
  before_action :set_crypted_note, except: [:verify, :verify_update, :request_access]
  before_action :set_crypted_note_for_permitted_contact, only: [:verify, :verify_update, :request_access]
  before_action :set_permitted_contact, only: %i[show edit update destroy reject_access approve_access]

  # GET /permitted_contacts
  def index
    @permitted_contacts = @crypted_note.permitted_contacts
  end

  # GET /permitted_contacts/1
  def show
  end

  # GET /permitted_contacts/new
  def new
    @permitted_contact = PermittedContact.new
  end

  # GET /permitted_contacts/1/edit
  def edit
  end

  # POST /permitted_contacts
  def create
    @permitted_contact = @crypted_note.permitted_contacts.new(permitted_contact_params)

    if @permitted_contact.save
      CryptedNoteMailer.grant_permission_email(@permitted_contact).deliver_later

      redirect_to crypted_note_permitted_contacts_path, notice: "Permitted contact was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /permitted_contacts/1
  def update
    if @permitted_contact.update(permitted_contact_params)
      redirect_to crypted_notes_path, notice: "Permitted contact was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /permitted_contacts/1
  def destroy
    @permitted_contact.destroy
    redirect_to crypted_note_permitted_contacts_url(@crypted_note), notice: "Permitted contact was successfully destroyed.", status: :see_other
  end

  def verify
  end

  def verify_update
    if params[:permitted_contact][:has_verified_password]
      @permitted_contact.update!(verified_password_at: Time.now)
    end

    redirect_to root_path, notice: "You successfully verifed the password"
  end

  def request_access
    @permitted_contact.request_for_access!

    CryptedNoteMailer.request_access_email(@permitted_contact).deliver_later

    redirect_to root_path, notice: "We have requested decrypt request. If person will not reject the request until #{@permitted_contact.decrypt_access_granted_at.to_date}, you will be granted decrypt access automatically."
  end

  def reject_access
    @permitted_contact.reject_access!

    redirect_to root_path, notice: "Access to the secret for #{@permitted_contact.email} has been rejected"
  end

  def approve_access
    @permitted_contact.approve_access!

    redirect_to root_path, notice: "Access to the secret for #{@permitted_contact.email} has been granted"
  end

  private

  def set_crypted_note
    @crypted_note = current_user.crypted_notes.find(params[:crypted_note_id])
  end

  def set_crypted_note_for_permitted_contact
    @permitted_contact = PermittedContact.find_by(email: current_user.email, id: params[:permitted_contact_id], crypted_note_id: params[:crypted_note_id])
    @crypted_note = @permitted_contact.crypted_note
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_permitted_contact
    @permitted_contact = @crypted_note.permitted_contacts.find(params[:id] || params[:permitted_contact_id])
  end

  # Only allow a list of trusted parameters through.
  def permitted_contact_params
    params.require(:permitted_contact).permit(:email, :auto_grant_decrypt_permission_in_x_days_after_the_request)
  end
end
