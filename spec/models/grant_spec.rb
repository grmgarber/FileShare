require 'rails_helper.rb'

RSpec.describe Grant do
  before(:each) do
    @grant = build(:grant)
  end

  it 'is invalid without upload_id' do
    @grant.upload_id = nil
    expect(@grant).to be_invalid
  end

  it 'is invalid without user_id' do
    @grant.user_id = nil
    expect(@grant).to be_invalid
  end

  it 'is invalid if another grant with the same upload_id has the same user_id' do
    another_grant = FactoryGirl.create(:grant, upload: @grant.upload, user: @grant.user)
    expect(@grant.save).to eq(false)  # Duplicate grant
  end

end
