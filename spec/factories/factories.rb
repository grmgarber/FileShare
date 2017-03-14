FactoryGirl.define do
  factory :user do
    sequence(:id) {|n| n}
    sequence(:email) {|n| "test#{n}@gmail.com"}
    password '123456'
  end

  factory :grant do

  end

  factory :upload do
    sequence(:id) {|n| n}
    sequence(:description) {|n| "description #{n}"}
    upl_file_file_name      'blabla.pdf'
    upl_file_content_type    'application/pdf'
    upl_file_file_size       24000
    upl_file_updated_at      DateTime.parse('2016-08-09 14:00')
    association :user, factory: :user
    # association :grants, factory: grant
  end
end




