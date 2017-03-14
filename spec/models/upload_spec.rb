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
end