require "rails_helper"

describe "管理者による職員管理", "ログイン前" do
  include_examples "a protected admin controller", "admin/staff_members"
end

describe "管理者による職員管理" do
  let(:administrator) {FactoryBot.create(:administrator)}

  before do
    post admin_session_url,
    params: {admin_login_form: {
      email: administrator.email,
      password: "pass"
    }}
  end

  describe "新規登録" do
    let(:params_hash) {FactoryBot.attributes_for(:staff_member)}

    example "職員一覧ページにリダイレクト" do
      post admin_staff_members_url, params: {staff_member: params_hash}
      expect(response).to redirect_to(admin_staff_members_url)
    end

    example "例外actioncontroller::parametermissingがハッセイ" do
      expect {post admin_staff_members_url}.to raise_error(ActionController::ParameterMissing)
    end
  end

  describe "更新" do
    let(:staff_member) {FactoryBot.create(:staff_member)}
    let(:params_hash) {FactoryBot.attributes_for(:staff_member)}

    example "suspendedフラグをセットする" do
      params_hash.merge!(suspended: true)
      patch admin_staff_member_url(staff_member),
        params: {staff_member: params_hash}
      staff_member.reload
      expect(staff_member).to be_suspended
    end

    example "hashed_passwordの値は書き換えできない" do
      params_hash.delete(:password)
      params_hash.merge!(password_digest: "x")
      expect{
        patch admin_staff_member_url(staff_member),
          params: {staff_member: params_hash}
      }.not_to change{staff_member.password_digest.to_s}
    end
  end
end