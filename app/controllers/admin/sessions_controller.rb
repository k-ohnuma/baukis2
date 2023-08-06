class Admin::SessionsController < Admin::Base
  skip_before_action :authorize
  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render "new"
    end
  end
  def create
    @form = Admin::LoginForm.new(login_form_params) 
    if @form.email.present?
      admin_member = Administrator.find_by("lower(email) = ?", @form.email.downcase)
    end
    if admin_member && Admin::Authenticator.new(admin_member).authenticate(@form.password)
      session[:administrator_id] = admin_member.id
      flash.notice = "管理者としてログインしました！"
      redirect_to :admin_root
    else
      # flash.notice = "ログイン失敗...desu"
      flash.now[:alert] = "ログイン失敗です。"
      # @flash_alert = "ログインに失敗しました"
      render :new
    end
  end
  def destroy
    session.delete(:administrator_id)
    flash.notice = "ログアウトしました"
    redirect_to :admin_root, status: :see_other
  end

  private
    def login_form_params
      params.require(:admin_login_form).permit(:email, :password)
    end


end
