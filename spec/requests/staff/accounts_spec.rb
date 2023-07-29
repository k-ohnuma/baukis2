require 'rails_helper'

describe "職員による自分のアカウントの管理" do
  before do
    post staff_session_url,
    params: {
      staff_login_form: {
        email: staff_member.email,
        password: "pass"
      }
    }
  end
  describe "更新" do
    let(:params_hash){FactoryBot.attributes_for(:staff_member)}
    let(:staff_member){FactoryBot.create(:staff_member)}
    example "email属性の変更" do
      params_hash.merge!(email: "ohnuma@kore.co.jp")
      puts params_hash
      patch staff_account_url,
        params: {id: staff_member.id, staff_member: params_hash}
      staff_member.reload
      expect(staff_member.email).to eq("ohnuma@kore.co.jp")
    end
  end
end
