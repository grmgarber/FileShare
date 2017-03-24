require 'rails_helper.rb'

RSpec.describe User do

  let(:user) {build(:user)}

  it 'is of class User' do
    puts "User = #{user}"
    expect(user).to be_a(User)
  end

  it 'contains id' do
    expect(user.id).to be_a(Numeric)
  end

  it 'contains email of type String' do
    expect(user.email).to be_a(String)
  end

  it 'calculates potential grantee email correctly' do
    user1 = create(:user, email: 'margared@test.com')
    user2 = create(:user)   # Will play the role of the current user
    user3 = create(:user)
    user4 = create(:user, email: 'garber@greg.com')
    user5 = create(:user)

    upload = create(:upload, user: user2)

    grant1 = create(:grant, upload: upload, user: user3)
    grant2 = create(:grant, upload: upload, user: user5)

    # user2 owns the upload. users user3 and user5 have grants to view the upload
    # we expect user1 and user4 to be the potential grantees when <term> is omitted in potential_grantee_emails call.

    expect(User.potential_grantee_emails(user2.id, upload.id)).to contain_exactly(user1.email, user4.email)
    expect(User.potential_grantee_emails(user2.id, upload.id, 'gar')).to contain_exactly(user1.email, user4.email)
    expect(User.potential_grantee_emails(user2.id, upload.id, 'gare')).to contain_exactly(user1.email)
    expect(User.potential_grantee_emails(user2.id, upload.id, 'garb')).to contain_exactly(user4.email)
    expect(User.potential_grantee_emails(user2.id, upload.id, 'aret')).to be_empty
  end
end

