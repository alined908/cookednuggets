Feature: Account

    As a new user
    I want to signup/login/logout
    So that I can use the site

    Scenario: Reach signup from landing page
      Given no current user
      When I am on the home page
      And I follow "Sign Up"
      Then I should be on the signup page

    Scenario: Login an account
      Given a registered user with email "daniel@gmail.com" with password "password" exists
      When I am on the login page
      And I fill in "Email" with "daniel@gmail.com"
      And I fill in "Password" with "password"
      And I press "Login"
      Then I should see "Signed in successfully"
