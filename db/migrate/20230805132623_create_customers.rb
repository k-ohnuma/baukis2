class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :email, null: false
      t.string :family_name, null: false
      t.string :given_name, null: false
      t.string :family_name_kana, null: false
      t.string :given_name_kana, null: false
      t.string :gender
      t.date :birthday
      t.string :password_digest
      t.timestamps
    end
    add_index :customers, "LOWER(email)", unique: true
    add_index :customers, [:family_name_kana, :given_name_kana]
  end
end
