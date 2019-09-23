module Features
  module SessionHelpers
    def sign_up_with(email, password, confirm)
      visit new_user_registration_path
      fill_in 'user[firstname]', :with => "daniel"
      fill_in 'user[lastname]', :with => "lee"
      fill_in 'user[username]', :with => "alined"
      fill_in 'user[email]', :with => email
      fill_in 'user[password]', :with => password
      fill_in 'user[password_confirmation]', :with => confirm
    end

    def sign_in
      user = create(:user)
      visit new_user_session_path
      fill_in 'user[email]', :with => user.email
      fill_in 'user[password]', :with => user.password
      click_button 'Login'
    end
  end
end
