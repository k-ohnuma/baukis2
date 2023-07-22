FactoryBot.define do
  factory :administrator do
    sequence(:email) {|n| "member#{n}@admin.com"}
    password {"pass"}
    suspended {false}
  end
end
