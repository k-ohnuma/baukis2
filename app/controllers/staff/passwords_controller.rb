class Staff::PasswordsController < Staff::Base
  def show
    redirect_to :edit_staff_password
  end

  def edit
    @change_password_form = Staff::ChangePasswordForm.new(object: current_staff_member)
  end

  def update
    @change_password_form = Staff::ChangePasswordForm.new(staff_member_params)
    logger.debug(staff_member_params)
    @change_password_form.object = current_staff_member
    logger.debug(@change_password_form.object.email)
    if @change_password_form.save
      logger.debug("save")
      flash.notice = "パスワードを変更しました"
      redirect_to :staff_account
    else
      logger.debug("not save")
      flash.notice = "入力ミスってます"
      redirect_to :staff_account
    end
  end

  private
    def staff_member_params
      params.require(:staff_change_password_form).permit(:current_password, :new_password, :new_password_confirmation)
    end
end
