Given /^no current user$/ do
  page.driver.submit :delete, "/users/sign_out", {}
end

Given /^a registered user with email "(.*)" with password "(.*)" exists$/ do |email, password|
  User.create(:username => "dddd", :email => email, :firstname => "Daniel",
  :lastname => "Lee", :password => "password")
end

Given /^I login as user with email "(.*)" and password "(.*)"$/ do |email, password|
  visit new_user_session_path
  fill_in 'Email', :with => email
  fill_in 'Password', :with => password
  click_button "Login"
end
