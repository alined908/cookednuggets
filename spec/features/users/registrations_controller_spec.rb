require 'spec_helper'

feature 'Visitor signs up' do
  scenario "with valid credentials" do
    sign_up_with("daniel@berkeley.edu", "password", "password")
    select 'us', :from => 'user_country'
  	click_button 'Sign Up!'
  	expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario 'with invalid credentials' do
    sign_up_with("daniel@berkeley.edu", "nope", "password")
    select 'us', :from => 'user_country'
  	click_button 'Sign Up!'
  	expect(page).to have_css(".alert-danger")
  end

  def sign_up_with(email, password, confirm)
    visit new_user_registration_path
    fill_in 'user[firstname]', :with => "daniel"
    fill_in 'user[lastname]', :with => "lee"
    fill_in 'user[username]', :with => "alined"
    fill_in 'user[email]', :with => email
  	fill_in 'user[password]', :with => password
  	fill_in 'user[password_confirmation]', :with => confirm
  end
end
