# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_07_23_182612) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crypted_notes", force: :cascade do |t|
    t.bigint "user_id"
    t.text "description"
    t.text "crypted_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_password_hash"
    t.index ["user_id"], name: "index_crypted_notes_on_user_id"
  end

  create_table "permitted_contacts", force: :cascade do |t|
    t.bigint "crypted_note_id", null: false
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "verified_password_at"
    t.datetime "decrypt_access_requested_at"
    t.datetime "decrypt_access_granted_at"
    t.datetime "decrypt_access_rejected_at"
    t.integer "auto_grant_decrypt_permission_in_x_days_after_the_request", default: 180
    t.index ["crypted_note_id"], name: "index_permitted_contacts_on_crypted_note_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "permitted_contacts", "crypted_notes"
end
