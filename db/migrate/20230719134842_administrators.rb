class Administrators < ActiveRecord::Migration[7.0]
  def change
    remove_column :administrators, :email
    add_column :administrators, :email, :string, null: false
    remove_column :administrators, :password_digest
    add_column :administrators, :password_digest, :string
    remove_column :administrators, :suspended
    add_column :administrators, :suspended, :boolean, null: false, default: false

    add_index :administrators, "lower(email)", unique: true
  end
end
