class Admin::Authenticator
  def initialize(admin_member)
    @admin_member = admin_member
  end

  def authenticate(raw_password)
    @admin_member &&
    !@admin_member.suspended? &&
    @admin_member.password_digest &&
    BCrypt::Password.new(@admin_member.password_digest) == raw_password
  end
end