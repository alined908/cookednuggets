Given /^no current user$/ do
    page.driver.submit :delete, "/logout", {}
end

Given /^a registered user with the email "(.*)" with password "(.*)" exists$/ do |email, password|
    User.create(:username => "ddd", :email => email, :firstname => "Daniel",
    :lastname => "Lee", :password => password)
end
