json.extract! email, :id, :email, :status, :source, :description, :unsubscribed, :created_at, :updated_at
json.url email_url(email, format: :json)