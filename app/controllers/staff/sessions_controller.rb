class Staff::SessionsController < Staff::Base
  skip_before_action :authorize
  skip_before_action :check_timeout
  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: "new"
    end
  end
  
  def create
    puts login_form_params[:email]
    @form = Staff::LoginForm.new(login_form_params) if login_form_params[:email].present?
      staff_member = StaffMember.find_by("lower(email) = ?", @form.email.downcase)
    
    # if staff_member.suspended?
    #   flash.notice = "アカウントバンされてるで"
    #   staff_member.staff_events.create!(type: "rejected")
    #   redirect_to :staff_root
    # else
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      session[:staff_member_id] = staff_member.id
      session[:last_access_time] = Time.current
      flash.notice = "ログインしました"
      staff_member.staff_events.create!(type: "logged_in")
      redirect_to :staff_root
    else
      flash.notice = "メールアドレスまたはパスワードが正しくありません"
      render action: "new"
    end
    # end
  end

  def destroy
    if current_staff_member
      current_staff_member.staff_events.create!(type: "logged_out")
    end
    session.delete(:staff_member_id)
    flash.notice = "ログアウトしました"
    redirect_to :staff_root, status: :see_other
  end

  private
  def login_form_params
    params.require(:staff_login_form).permit(:email, :password)
  end
end
