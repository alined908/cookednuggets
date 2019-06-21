require 'spec_helper'

RSpec.describe Users::SessionsController, :type => :controller do
  before do
    @user = create(:user)
  end

  describe "Login" do
    it "should log in to my account" do
    	visit new_user_session_path
    	fill_in 'user[email]', :with => @user.email
    	fill_in 'user[password]', :with => @user.password
    	click_button 'Login'
    	expect(page).to have_content "Signed in successfully."
    end
  end
end
