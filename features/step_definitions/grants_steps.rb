Given /^User is signed in$/ do
  @user = User.create(email: 'test@example.com', password: 'TestPass')
  visit new_user_session_path
  fill_in('user[email]',    with: @user.email)
  fill_in('user[password]', with: @user.password)
  click_button 'Log in'
end

And /^There are other users - potential viewers$/ do
  @user1 = User.create(email: 'test1@example.com', password: 'TestPass')
end

And /^Signed in user has an upload$/ do
  click_link 'New Upload'
  attach_file('upload[upl_file]',File.join(Rails.root.to_s,'spec/fixtures/files','Details.png'))
  fill_in('upload[description]', with: 'blabla')
  click_button 'Create Upload'
end

And /^User visits Edit Upload page$/ do
  within('tr td:last-child') do
    click_link 'Edit'
  end
end

And /^User selects Access by Other Users tab$/ do
  page.all('#accordion h3').last.click
end

When  /^Another existing user has been designated as a viewer$/ do
  fill_in('email', with: @user1.email)
  click_on 'Add Viewer'
end

Then  /^Viewer's email is shown in the list of viewers$/ do
  expect(page).to have_selector('.list .list-item span', text: @user1.email)
end

And   /^Delete button is displayed next to the viewer's email$/ do
  expect((page.find('.list .list-item a'))[:title]).to eq('Remove Viewer')
end

