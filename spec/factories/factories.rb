FactoryGirl.define do
  factory :user do
    sequence(:id) {|n| n}
    sequence(:email) {|n| "test#{n}@gmail.com"}
    encrypted_password User.new.send(:password_digest,'123456')
    password '123456'
  end

  factory :upload do
    sequence(:id) {|n| n}
    sequence(:description) {|n| "description #{n}"}
    upl_file File.new(File.join(Rails.root.to_s, 'spec/fixtures/files', 'Details.png'), 'rb')
    association :user, factory: :user
  end

  factory :grant do
    sequence(:id) {|n| n}
    association :upload, factory: :upload
    association :user, factory: :user
  end

end




