require 'rails_helper'

RSpec.describe Administrator, type: :model do
  describe "password hash test" do
    example "administratorsのpassword test!" do
      admin = Administrator.new
      admin.password = "password"
      expect(admin.password_digest).to be_kind_of(String)
      expect(admin.password_digest.size).to eq(60)
    end

    example "password nil test" do
      admin = Administrator.new(password_digest: "password!!")
      admin.password = nil
      expect(admin.password_digest).to be_nil
    end
  end
end
