class StaffMember < ApplicationRecord
  has_secure_password
  # def password=(raw_password)
  #   if raw_password.kind_of?(String)
  #     self.hashed_password = BCrypt::Password.create(raw_password)
  #   elsif raw_password.nil?
  #     self.hashed_password = nil
  #   end
  # end

  def active?
    !self.suspended? && start_date <= Date.today &&
    (end_date.nil? || end_date >= Date.tomorrow)
  end
end
