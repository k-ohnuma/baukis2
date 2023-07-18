class StaffMember < ActiveRecord::Migration[7.0]
  def change
    add_column :staff_members, :email, :string, :null => false
    add_column :staff_members, :family_name, :string, :null => false
    add_column :staff_members, :given_name, :string, :null => false
    add_column :staff_members, :family_name_kana, :string, :null => false
    add_column :staff_members, :given_name_kana, :string, :null => false
    add_column :staff_members, :hashed_password, :string
    add_column :staff_members, :start_date, :date, :null => false
    add_column :staff_members, :end_date, :date
    add_column :staff_members, :suspended, :boolean, default: false, null: false
    # change_column :staff_members, :suspended, default: false, :null => false
    #Ex:- :default =>''
    #Ex:- :null => false

    #Ex:- :null => false
    add_index :staff_members, "LOWER(email)", unique: true
    add_index :staff_members, [:family_name_kana, :given_name_kana]
  end
end
