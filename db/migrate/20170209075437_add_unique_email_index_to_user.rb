# frozen_string_literal: true

class AddUniqueEmailIndexToUser < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
  end
end
