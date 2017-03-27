require 'rails_helper'
require 'support/devise'

RSpec.describe UploadsController, type: :controller do

  def create_test_upload
    fs = File.join(Rails.root.to_s,'spec/fixtures/files','Details.png')
    uf = Rack::Test::UploadedFile.new(fs)
    post :create, upload: { upl_file: uf, description: 'test upload'}
  end

  context "signed in" do
    before :each do
      sign_in create(:user)   # we need support/devise for  sign_in method
    end

    describe "POST create with signed in user" do
      it "creates a new upload" do
        count = Upload.count
        # fs = File.join(Rails.root.to_s,'spec/fixtures/files','Details.png')
        # uf = Rack::Test::UploadedFile.new(fs)
        # post :create, upload: { upl_file: uf, description: 'test upload'}
        create_test_upload
        expect(Upload.count).to eq(count + 1)
        expect(response).to redirect_to(uploads_path)
        expect(flash.now[:notice]).to eq('Upload created successfully')
      end
    end
  end

  context "signed OUT" do
    describe "POST create with signed out user" do
      it "redirects to sign-in page" do
        count = Upload.count
        fs = File.join(Rails.root.to_s,'spec/fixtures/files','Details.png')
        uf = Rack::Test::UploadedFile.new(fs)
        post :create, upload: { upl_file: uf, description: 'test upload'}
        expect(Upload.count).to eq(count)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end