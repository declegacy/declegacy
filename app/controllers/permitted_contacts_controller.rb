class PermittedContactsController < ApplicationController
  before_action :set_crypted_note, except: [:verify, :verify_update]
  before_action :set_crypted_note_for_verify, only: [:verify, :verify_update]
  before_action :set_permitted_contact, only: %i[show edit update destroy]

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
      redirect_to crypted_note_permitted_contacts_path, notice: "Permitted contact was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /permitted_contacts/1
  def update
    if @permitted_contact.update(permitted_contact_params)
      redirect_to @permitted_contact, notice: "Permitted contact was successfully updated.", status: :see_other
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
    has_verified_password = params[:permitted_contact][:has_verified_password]

    if has_verified_password
      @permitted_contact.update!(has_verified_password: true, verified_password_at: Time.now)
    end

    redirect_to root_path, notice: "You successfully verifed the password"
  end

  private

  def set_crypted_note
    @crypted_note = current_user.crypted_notes.find(params[:crypted_note_id])
  end

  def set_crypted_note_for_verify
    @permitted_contact = PermittedContact.find_by(email: current_user.email, id: params[:permitted_contact_id], crypted_note_id: params[:crypted_note_id])
    @crypted_note = @permitted_contact.crypted_note
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_permitted_contact
    @permitted_contact = @crypted_note.permitted_contacts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def permitted_contact_params
    params.require(:permitted_contact).permit(:email)
  end
end
