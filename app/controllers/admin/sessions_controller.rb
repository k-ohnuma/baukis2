class Admin::SessionsController < Admin::Base
  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render :new
    end
  end
  def create
    @form = Admin::LoginForm.new(params[:admin_login_form]) 
    if @form.email.present?
      admin_member = Administrator.find_by("lower(email) = ?", @form.email.downcase)
    end
    if admin_member && Admin::Authenticator.new(admin_member).authenticate(@form.password)
      session[:administrator_id] = admin_member.id
      flash.notice = "管理者としてログインしました！"
      redirect_to :admin_root
    else
      flash.notice = "ログイン失敗..."
      render :new
    end
  end
  def destroy
    session.delete(:administrator_id)
    flash.notice = "ログアウトしました"
    redirect_to :admin_root, status: :see_other
  end
end
