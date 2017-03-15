require 'rails_helper.rb'

RSpec.describe Upload do

  before(:each) do
    @upload = build(:upload)
  end

  it 'is of class Upload' do
    expect(@upload).to be_a(Upload)
  end

  it 'fails validation when description is missing' do
    @upload.description = nil
    expect(@upload).to be_invalid
  end

  it 'fails validation when user is missing' do
    @upload.user = nil
    expect(@upload).to be_invalid
  end

  it 'fails validation when file name is missing' do
    @upload.upl_file_file_name = ''
    expect(@upload).to be_invalid
  end

  it 'fails validation when content type is application/xls' do
    @upload.upl_file_content_type = 'application/xls'
    expect(@upload).to be_invalid
  end

  it 'fails validation when file size = 0' do
    @upload.upl_file_file_size = 0
    expect(@upload).to be_invalid
  end

  it 'passes validation when description is present' do
    expect(@upload).to be_valid
  end

  it 'returns expected uploads from ' do
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)

    upload1 = create(:upload, user: user1)
    upload2 = create(:upload, user: user2)

    grant1 = create(:grant, upload: upload1, user: user2)

    uploads_viewable_by_u2 = Upload.all_viewable_by(user2).to_a
    expect(uploads_viewable_by_u2.size).to eq(2)
    expect(uploads_viewable_by_u2.include?(upload1)).to be_truthy   # granted upload
    expect(uploads_viewable_by_u2.include?(upload2)).to be_truthy   # own upload

    uploads_viewable_by_u1 = Upload.all_viewable_by(user1).to_a
    expect(uploads_viewable_by_u1.size).to eq(1)
    expect(uploads_viewable_by_u1.include?(upload1)).to be_truthy

    uploads_viewable_by_u3 = Upload.all_viewable_by(user3)
    expect(uploads_viewable_by_u3).to be_empty

  end

end