class AddMultiColumnIndexToEmails < ActiveRecord::Migration
  def change
    remove_index :emails, :name => "index_emails_on_email"
    add_index :emails, [:email, :source], unique: true
  end
end
