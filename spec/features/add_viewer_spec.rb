require 'rails_helper'

describe "adding a new viewer (grantee) to an upload" do

  def log_in_as(user)
    visit new_user_session_path
    fill_in('user[email]',    with: user.email)
    fill_in('user[password]', with: user.password)
    click_button 'Log in'
  end

  let(:user) {User.create(email: 'test@example.com', password: 'TestPass')}

  it "can add a viewer to an upload" do
    log_in_as(user)
    expect(current_path).to eq(root_path)
    click_link 'New Upload'
    expect(current_path).to eq(new_upload_path)
    attach_file('upload[upl_file]',File.join(Rails.root.to_s,'spec/fixtures/files','Details.png'))
    fill_in('upload[description]', with: 'blabla')
    click_button 'Create Upload'
    expect(current_path).to eq(uploads_path)
    within('.flash') do
      expect(page).to have_selector('.notice', text: 'Upload created successfully')
    end
  end
end
