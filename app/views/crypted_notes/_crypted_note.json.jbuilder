json.extract! crypted_note, :id, :created_at, :updated_at
json.url crypted_note_url(crypted_note, format: :json)
