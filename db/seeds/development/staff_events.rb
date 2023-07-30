staff_members = StaffMember.all

256.times do |n|
  sm = staff_members.sample
  e = sm.staff_events.build
  if sm.active?
    if n % 2 == 0
      e.type = "logged_in"
    else
      e.type = "logged_out"
    end
  else
    e.type = "rejected"
  end
  e.occurred_at = (256 - n).hours.ago
  e.save!
end