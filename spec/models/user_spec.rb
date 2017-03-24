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

  describe 'potential_grantee_emails are calculated correctly' do
    before :each do    # Before :each gets rolled back after each test, before :all does not get rolled back
      @user1  = create(:user, email: 'margared@test.com')
      @user2  = create(:user, email: 'test1@test.com')   # Will play the role of the current user
      @user3  = create(:user, email: 'test2@test.com')
      @user4  = create(:user, email: 'garber@greg.com')
      @user5  = create(:user, email: 'test5@test.com')
      @user6  = create(:user, email: 'test6@test.com')
      @user7  = create(:user, email: 'test7@test.com')
      @upload = create(:upload, user: @user2)
      @grant1 = create(:grant, upload: @upload, user: @user3)
      @grant2 = create(:grant, upload: @upload, user: @user5)
    end

    it 'when no term is specified, user1 and user4 emails are returned' do
      expect(User.potential_grantee_emails(@user2.id, @upload.id)).to contain_exactly(@user1.email, @user4.email, @user6.email, @user7.email)
    end

    it 'when shared term is specified, user1 and user4 emails are returned' do
      expect(User.potential_grantee_emails(@user2.id, @upload.id, term: 'gar')).to contain_exactly(@user1.email,@user4.email)
    end

    it 'when unique term of user1 email is specified, it is the only email returned' do
      expect(User.potential_grantee_emails(@user2.id, @upload.id, term: 'gare')).to contain_exactly(@user1.email)
    end

    it 'when a term that satisfies neither user email is specified, an empty array is returned' do
      expect(User.potential_grantee_emails(@user2.id, @upload.id, term: 'aret')).to be_empty
    end

    it 'when a term that satisfies neither user email is specified, an empty array is returned' do
      pge = User.potential_grantee_emails(@user2.id, @upload.id, term: 'est', limit: 2)
      expect(pge.size).to eq(3)
      expect(pge[-1]).to eq(User::MORE_AVAILABLE)
    end

  end
end

