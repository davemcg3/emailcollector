# frozen_string_literal: true

class AddUniqueIndexToEmails < ActiveRecord::Migration
  def change
    add_index :emails, :email, unique: true
  end
end
