require 'rails_helper'
require 'support/devise'

RSpec.describe UploadsController, type: :controller do

  def test_upload_file
    fs = File.join(Rails.root.to_s,'spec/fixtures/files','Details.png')
    Rack::Test::UploadedFile.new(fs)
  end

  context "signed in" do
    before :each do
      sign_in create(:user)   # we need support/devise for  sign_in method
    end

    describe "POST create with signed in user" do
      it "creates a new upload" do
        count = Upload.count
        post :create, upload: { upl_file: test_upload_file, description: 'test upload'}
        expect(Upload.count).to eq(count + 1)
        expect(response).to redirect_to(uploads_path)
        expect(flash.now[:notice]).to eq('Upload created successfully')
      end
    end

    describe "PUT update with signed in user" do
      it "updates the upload and redirects to uploads_path" do
        # Here we will use Partial Stubs for Upload class and instance
        ps_upload = Upload.new(description: 'blabla')
        expect(Upload).to receive(:find).and_return(ps_upload)
        expect(ps_upload).to receive(:description=)
        expect(ps_upload).to receive(:save).and_return(true)
        expect(ps_upload).to receive(:id).and_return(5)
        patch :update, id: 5, upload: {description: 'hohoho'}
        expect(response).to redirect_to(edit_upload_path(5))
        expect(flash.now[:notice]).to eq('Description updated successfully')
      end
    end
  end

  context "signed OUT" do
    describe "POST create with signed out user" do
      it "redirects to sign-in page" do
        count = Upload.count
        post :create, upload: { upl_file: test_upload_file, description: 'test upload'}
        expect(Upload.count).to eq(count)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
