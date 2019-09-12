require 'spec_helper'

RSpec.describe Users::SessionsController, :type => :controller do
  before do
    @user = create(:user)
  end

  describe "Login" do
    scenario "with valid credentials" do
    	sign_in_with(@user.email, @user.password)
    	expect(page).to have_content "Signed in successfully."
    end

    scenario 'with invalid credentials' do
      sign_in_with(@user.email, "dwadwda")
      expect(page).to have_content "Invalid Email or password."
    end
  end

  describe "Logout" do
    scenario "" do
      sign_in_with(@user.email, @user.password)
      click_link "Log Out"
      expect(page).to have_content "Signed out successfully."
    end
  end

  def sign_in_with(email, password)
    visit new_user_session_path
    fill_in 'user[email]', :with => email
    fill_in 'user[password]', :with => password
    click_button 'Login'
  end
end
