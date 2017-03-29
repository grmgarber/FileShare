Given /^The current session logged out$/ do
  visit new_user_session_path
  expect(current_path).to eq(new_user_session_path)
end

And /^An existing user with email (.+@.+) and password (.+) logs in$/ do |email, password|
  FactoryGirl.create(:user, email: email, password: password, encrypted_password: User.new.send(:password_digest,password))
  fill_in('user[email]',    with: email)
  fill_in('user[password]', with: password)
  click_button 'Log in'

end

Then /^The home page is displayed$/ do
  expect(current_path).to eq(root_path)
end




