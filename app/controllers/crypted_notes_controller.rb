class CryptedNotesController < ApplicationController
  before_action :set_crypted_note, only: %i[show edit update destroy]

  # GET /crypted_notes or /crypted_notes.json
  def index
    @crypted_notes = current_user.crypted_notes
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
  end

  # POST /crypted_notes or /crypted_notes.json
  def create
    @crypted_note = current_user.crypted_notes.new(crypted_note_params)

    respond_to do |format|
      if @crypted_note.save
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
  # def update
  #   respond_to do |format|
  #     if @crypted_note.update(crypted_note_params)
  #       format.html { redirect_to crypted_note_url(@crypted_note), notice: "Crypted note was successfully updated." }
  #       format.json { render :show, status: :ok, location: @crypted_note }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @crypted_note.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

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
    @crypted_note = current_user.crypted_notes.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def crypted_note_params
    params.fetch(:crypted_note).permit(:description, :crypted_content)
  end
end
