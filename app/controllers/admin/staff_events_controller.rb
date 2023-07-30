class Admin::StaffEventsController < Admin::Base
  def index
    if params[:staff_member_id]
      @staff_member = StaffMember.find(params[:staff_member_id])
      @events = @staff_member.staff_events.order(occurred_at: :desc)
    else
      @events = StaffEvent.order(occurred_at: :desc)
    end
  end
end
