require "rails_helper"

describe Staff::Authenticator do
  describe "#authenticator" do
    example "正しいpassword => true" do
      m = FactoryBot.build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate("pass")).to be_truthy
    end

    example "誤ったpassword => false" do
      m = FactoryBot.build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate("pw")).to be_falsey
    end

    example "パスワード未設定はfalseを返してください" do
      m = FactoryBot.build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(m).authenticate("pass")).to be_falsey
    end

    example "停止フラグ立ってるならfalseを返してくれますよね" do
      m = FactoryBot.build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(m).authenticate("pass")).to be_falsey
    end

    example "開始前ならfalse" do
      m = FactoryBot.build(:staff_member, start_date: Date.today.next_month)
      expect(Staff::Authenticator.new(m).authenticate("pass")).to be_falsey
    end

    example "退職後だったらfalse" do
      m = FactoryBot.build(:staff_member, end_date: Date.yesterday)
      expect(Staff::Authenticator.new(m).authenticate("pass")).to be_falsey
    end
  end
end