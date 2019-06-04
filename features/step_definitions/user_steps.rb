Given /^no current user$/ do
    page.driver.submit :delete, "/users/sign_out", {}
end

Given /^a registered user with email "(.*)" with password "(.*)" exists$/ do |email, password|
    User.create(:username => "dddd", :email => email, :firstname => "Daniel",
    :lastname => "Lee", :password => "password")
end
