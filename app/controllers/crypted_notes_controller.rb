class CryptedNotesController < ApplicationController
  before_action :set_crypted_note, only: %i[show edit update destroy]

  # GET /crypted_notes or /crypted_notes.json
  def index
    @crypted_notes = base_query
  end

  # GET /crypted_notes/1 or /crypted_notes/1.json
  def show
  end

  # GET /crypted_notes/new
  def new
    @crypted_note = current_user.crypted_notes.new
  end

  # GET /crypted_notes/1/edit
  def edit
    @permitted_contact = @crypted_note.permitted_contacts.where(email: current_user.email)

    @permitted_contact&.update(encrypted_content_accessed_at: Time.now)
  end

  # POST /crypted_notes or /crypted_notes.json
  def create
    @crypted_note = current_user.crypted_notes.new(crypted_note_params)

    respond_to do |format|
      if @crypted_note.save
        CryptedNoteMailer.grant_permission_email(@crypted_note).deliver_later

        # format.html { redirect_to crypted_note_url(@crypted_note), notice: "Crypted note was successfully created." }
        format.html { redirect_to crypted_notes_url, notice: "Crypted note was successfully created." }

        format.json { render :show, status: :created, location: @crypted_note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @crypted_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crypted_notes/1 or /crypted_notes/1.json
  def update
    raise "no access" if @crypted_note.user_id != current_user.id

    @crypted_note.update(crypted_note_params)

    CryptedNoteMailer.secret_backup_email(@crypted_note).deliver_later

    redirect_to crypted_notes_url, notice: "Crypted note was successfully updated."
  end

  # DELETE /crypted_notes/1 or /crypted_notes/1.json
  # def destroy
  #   @crypted_note.destroy

  #   respond_to do |format|
  #     format.html { redirect_to crypted_notes_url, notice: "Crypted note was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_crypted_note
    permitted_ids = PermittedContact.where(email: current_user.email).where("decrypt_access_granted_at IS NOT NULL").pluck(:crypted_note_id)

    @crypted_note = CryptedNote.where("user_id = ? or id IN(?)", current_user.id, permitted_ids).find(params[:id])
  end

  def base_query
    permitted_ids = PermittedContact.where(email: current_user.email).pluck(:crypted_note_id)

    CryptedNote.where("user_id = ? or id IN(?)", current_user.id, permitted_ids)
  end

  # Only allow a list of trusted parameters through.
  def crypted_note_params
    params.fetch(:crypted_note).permit(:description, :crypted_content, :short_password_hash)
  end
end
