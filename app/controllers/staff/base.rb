class Staff::Base < ApplicationController
  before_action :authorize
  before_action :check_timeout
  before_action :check_account
  private
  def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||= StaffMember.find_by(id: session[:staff_member_id])
    end
  end

  def authorize
    unless current_staff_member
      flash.notice = "ログインしてください"
      redirect_to :staff_login
    end
  end

  def check_account
    if current_staff_member && !current_staff_member.active?
      session.delete(:staff_member_id)
      flash.alert = "アカウント無効"
      redirect_to :staff_root
    end
  end

  TIMEOUT = 60.minutes

  def check_timeout
    if current_staff_member
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        session.delete(:staff_member_id)
        flash.notice = "セッション終了しました。再ログインしてください"
        redirect_to :staff_login
      end
    end
  end

  helper_method :current_staff_member
end