city_names = %w(館林市 浜松市 大宮市)


family_names = %w(
  大沼:オオヌマ:ohnuma
  佐藤:サトウ:sato
  藤井:フジイ:fuji
  松本:マツモト:matsumoto
  高橋:タカハシ:takahashi
  大阪:オオサカ:ohsaka
  山内:ヤマウチ:yamauchi
  川田:カワダ:kawada
  大河原:オオカワラ:ohkawara
  金子:カネコ:kaneko
)

given_names = %w(
  紘平:コウヘイ:kohei
  かよ:カヨ:kayo
  真美:マミ:mami
  正敏:マサトシ:masatoshi
  人志:ヒトシ:hitoshi
  悟:サトル:satoru
  哲平:テッペイ:teppei
  晋也:シンヤ:shinya
  理子:リコ:riko
  くるみ:クルミ:kurumi
)

company_names = %w(ABC HAW XYZ)

10.times do |n|
  10.times do |m|
    fn = family_names[n].split(':')
    gn = given_names[m].split(':')

    c = Customer.create(
      email: "#{fn[2]}-#{gn[2]}@example.com",
      family_name: "#{fn[0]}",
      given_name: "#{gn[0]}",
      family_name_kana: "#{fn[1]}",
      given_name_kana: "#{gn[1]}",
      password: "pass",
      birthday: 60.years.ago.advance(seconds: rand(40.years)).to_date,
      gender: m < 5 ? "male" : "female"
    )
    c.create_home_address(
      postal_code: sprintf("%07d", rand(10000000)),
      prefecture: Address::PREFECTURE_NAMES.sample,
      city: city_names.sample,
      address1: "開発1-1-1",
      address2: "マンション1010",
    )

    if m % 3 == 0
      c.create_work_address(
        postal_code: sprintf("%07d", rand(10000000)),
        prefecture: Address::PREFECTURE_NAMES.sample,
        city: city_names.sample,
        address1: "試験110202",
        address2: "ビル1",
      )
    end
  end
end