class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :email
      t.boolean :status
      t.string :source
      t.string :description
      t.datetime :unsubscribed

      t.timestamps null: false
    end
  end
end
