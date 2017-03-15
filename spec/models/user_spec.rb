require 'rails_helper.rb'

RSpec.describe User do

  before(:each) do
    @user = build(:user)
  end

  it 'is of class User' do
    puts "User = #{@user}"
    expect(@user).to be_a(User)
  end

  it 'contains id' do
    expect(@user.id).to be_a(Numeric)
  end

  it 'contains email of type String' do
    expect(@user.email).to be_a(String)
  end
end
