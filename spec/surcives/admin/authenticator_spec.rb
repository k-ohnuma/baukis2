require "rails_helper"

describe Admin::Authenticator do
  describe "#authenticator" do
    example "正しいpasswordを入力してればtrue" do
      m = FactoryBot.build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate("pass")).to be_truthy
    end

    example "間違えたらfalseです" do
      m = FactoryBot.build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate("ohnuma")).to be_falsey
    end

    example "nilだったらfalseです" do
      m = FactoryBot.build(:administrator, password: nil)
      expect(Admin::Authenticator.new(m).authenticate("pass")).to be_falsey
    end

    example "banされてたらfalseです" do
      m = FactoryBot.build(:administrator, suspended: true)
      expect(Admin::Authenticator.new(m).authenticate("pass")).to be_falsey
    end
  end
end