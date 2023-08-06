class Customer < ApplicationRecord
  has_one :home_address, dependent: :destroy
  has_one :work_address, dependent: :destroy

  has_secure_password
end
