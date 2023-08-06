StaffMember.create!(
  email: "taro@example.com",
  family_name: "山田",
  given_name: "太郎",
  family_name_kana: "やまだ",
  given_name_kana: "たろう",
  password: "password",
  start_date: Date.today
)

family_names = %w(
  大沼:オオヌマ:ohnuma
  佐藤:サトウ:sato
  藤井:フジイ:fuji
  松本:マツモト:matsumoto
)

given_names = %w(
  紘平:コウヘイ:kohei
  かよ:カヨ:kayo
  真美:マミ:mami
  正敏:マサトシ:masatoshi
  人志:ヒトシ:hitoshi
)

20.times do |n|
  fn = family_names[n % 4].split(':')
  gn = given_names[n % 5].split(':')

  StaffMember.create(
    email: "#{fn[2]}-#{gn[2]}@example.com",
    family_name: "#{fn[0]}",
    given_name: "#{gn[0]}",
    family_name_kana: "#{fn[1]}",
    given_name_kana: "#{gn[1]}",
    password: "pass",
    start_date: (100 - n).days.ago.to_date,
    end_date: n == 0 ? Date.today : nil,
    suspended: n == 1,
  )
end