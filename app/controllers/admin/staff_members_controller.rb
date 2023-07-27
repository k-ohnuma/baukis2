class Admin::StaffMembersController < Admin::Base
  def index
    @staff_members = StaffMember.order(:family_name_kana, :given_name_kana)
  end

  def new
    @staff_member = StaffMember.new
  end

  def edit
    @staff_member = StaffMember.find_by(id: params[:id])
  end

  def show
    staff_member = StaffMember.find_by(id: params[:id])
    redirect_to [:edit, :admin, staff_member]
  end

   def create
      @staff_member = StaffMember.new(staff_member_params)
      # puts @staff_member.save
      if @staff_member.save
        flash.notice = "新規登録完了"
        redirect_to :admin_staff_members
      else
        render action: "new"
      end
   end

   def update
      @staff_member = StaffMember.find(params[:id])
      @staff_member.assign_attributes(staff_member_params)
      if @staff_member.save
        flash.notice = "更新しました"
        redirect_to :admin_staff_members
      else
        render action: "edit"
      end
   end

   def destroy
      @staff_member = StaffMember.find_by(id: params[:id])
      @staff_member.destroy!
      flash.notice = "職員アカウントを削除しました"
      redirect_to :admin_staff_members
   end

   private
    def staff_member_params
      params.require(:staff_member).permit(
        :email, :password, :family_name, :given_name,
        :family_name_kana, :given_name_kana,
        :start_date, :end_date, :suspended)
    end
end
