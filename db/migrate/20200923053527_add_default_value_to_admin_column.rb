# frozen_string_literal: true

class AddDefaultValueToAdminColumn < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :admin, :boolean, default: false
  end

  def down
    change_column :users, :admin, :boolean, default: nil
  end
end