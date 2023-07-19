require 'rails_helper'

RSpec.describe StaffMember, type: :model do
  describe "パスワードに文字列をセットすると60字のhashが生成" do
    example "hashed password?" do
      member = StaffMember.new
      member.password = "password"
      expect(member.password_digest).to be_kind_of(String)
      expect(member.password_digest.size).to eq(60)
    end
    example "パスワードにnilがセットされるとpassword_digestもnilが帰る" do
      member = StaffMember.new(password_digest: "pass")
      member.password = nil
      expect(member.password_digest).to be_nil
    end
  end

end

