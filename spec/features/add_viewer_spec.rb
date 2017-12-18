require 'rails_helper'

describe "adding a new viewer (grantee) to an upload" do

  def log_in_as(user)
    visit new_user_session_path
    fill_in('user[email]',    with: user.email)
    fill_in('user[password]', with: user.password)
    click_button 'Log in'
  end

  let(:user)  {User.create(email: 'test@example.com', password: 'TestPass')}
  let(:user1) {User.create(email: 'test1@example.com', password: 'TestPass')}
  let(:user2) {User.create(email: 'test2@example.com', password: 'TestPass')}

  it "can add a viewer to an upload", js: true do
    log_in_as(user)
    expect(current_path).to eq(root_path)
    click_link 'New Upload'
    expect(current_path).to eq(new_upload_path)
    attach_file('upload[upl_file]',File.join(Rails.root.to_s,'spec/fixtures/files','Details.png'))
    fill_in('upload[description]', with: 'blabla')
    click_button 'Create Upload'
    expect(current_path).to eq(uploads_path)
    within(:css, '.flash') do
      expect(page).to have_selector('.notice', text: 'Upload created successfully')
    end
    within(:css, 'tr td:last-child') do
      click_link 'Edit'
    end
    expect(page).to have_selector('h3', text: 'Edit Upload')
    expect(user1.email).to eq('test1@example.com')
    expect(user2.email).to eq('test2@example.com')
    page.assert_selector('#accordion h3.ui-accordion-header', count: 2)
    page.all('#accordion h3.ui-accordion-header').last.click
    expect(page.find('input#email').visible?).to be_truthy
  end
end
