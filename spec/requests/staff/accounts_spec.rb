require 'rails_helper'

# describe "職員による自分のアカウント管理", "ログイン前" do
#   include_examples "a protected singular staff controller", "staff/accounts"
# end

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
      # puts params_hash
      patch staff_account_url,
        params: {id: staff_member.id, staff_member: params_hash}
      staff_member.reload
      expect(staff_member.email).to eq("ohnuma@kore.co.jp")
    end
  end

  describe "情報表示" do
    # let(:staff_member){FactoryBot.create(:staff_member)}
    let(:staff_member){FactoryBot.create(:staff_member)}
    example "成功" do
      get staff_account_url
      expect(response.status).to eq(200)
    end

    example "停止フラグがセットされたら強制ログアウト" do
      staff_member.update_column(:suspended, true)
      get staff_account_url
      expect(response).to redirect_to(:staff_root)
    end

    example "セッションタイムアウト" do
      travel_to Staff::Base::TIMEOUT.from_now.advance(seconds: 1)
      get staff_account_url
      expect(response).to redirect_to(:staff_login)
    end
  end
end
