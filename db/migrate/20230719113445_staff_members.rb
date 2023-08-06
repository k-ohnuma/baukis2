class StaffMembers < ActiveRecord::Migration[7.0]
  def change
    remove_column :staff_members, :hashed_password
    add_column :staff_members, :password_digest, :string, null: false
  end
end
