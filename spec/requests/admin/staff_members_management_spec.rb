require "rails_helper"

describe "管理者による職員管理" do
  let(:Administrator) {create(:administrator)}

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
end