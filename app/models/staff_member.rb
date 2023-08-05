class StaffMember < ApplicationRecord
  include StringNormalizer

  before_validation do
    self.email = normalize_as_email(self.email)
    self.family_name = normalize_as_name(self.family_name)
    self.given_name = normalize_as_name(self.given_name)
    self.family_name_kana = normalize_as_furigana(self.family_name_kana)
    self.given_name_kana = normalize_as_furigana(self.given_name_kana)
  end

  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/
  validates :family_name, :given_name, presence: true
  validates :family_name_kana, :given_name_kana, presence: true, format: {with: KATAKANA_REGEXP, allow_blank: true}
  validates :email, presence: true, "valid_email_2/email": true, uniqueness: {case_sensitive: false}

  validates :start_date, presence: true, date: {
    after_or_equal_to: Date.new(2000, 1, 1),
    before: -> (obj) {1.year.from_now.to_date},
    allow_blank: true
  }


  has_many :staff_events, dependent: :destroy
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
