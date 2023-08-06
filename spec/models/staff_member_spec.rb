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

  describe "値の正規化" do
    example "email前後の空白の削除" do
      member = FactoryBot.create(:staff_member, email: " test@example.com ")
      expect(member.email).to eq("test@example.com")
    end

    example "emailに含まれる全角を半角に変換" do
      member = FactoryBot.create(:staff_member, email: "ｔeｓｔ@exaｍｐｌe.coｍ")
      expect(member.email).to eq("test@example.com")
    end

    example "family_name_kanaのひらがなをカタカタに変換" do
      member = FactoryBot.create(:staff_member, family_name_kana: "てすと")
      expect(member.family_name_kana).to eq("テスト")
    end
  end

  describe "バリデーション" do
    example "@を2個含むemailは無効か" do
      member = FactoryBot.build(:staff_member, email: "test@@example.com")
      expect(member).not_to be_valid
    end
  end

end

