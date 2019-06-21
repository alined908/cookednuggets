require 'spec_helper'

RSpec.describe Users::RegistrationsController, :type => :controller do
  describe "Sign Up" do
    it "should create new user account" do
    	visit new_user_registration_path
      fill_in 'user[firstname]', :with => "daniel"
      fill_in 'user[lastname]', :with => "lee"
      fill_in 'user[username]', :with => "alined"
    	fill_in 'user[email]', :with => "daniel@berkeley.edu"
    	fill_in 'user[password]', :with => "password"
    	fill_in 'user[password_confirmation]', :with => "password"
    	click_button 'Sign Up!'
    	expect(page).to have_content "Welcome! You have signed up successfully."
    end
  end
end
