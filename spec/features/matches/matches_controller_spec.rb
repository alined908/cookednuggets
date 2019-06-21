require 'spec_helper'

RSpec.describe Matches::MatchesController, :type => :controller do
  before(:each) do
    @user = create(:user)
    @match = create(:match)
    @match.user = @user
    login_as(@user, :scope => :user)
    visit root_path
  end

  describe 'matches on navbar' do
    it 'shows matches if logged in' do
      expect(page).to have_content "Matches"
    end
    it 'doesnt show matches if not logged in' do
      click_on "Log Out"
      expect(page).to_not have_content "Matches"
    end
    it 'directs to matches#index' do
      click_on "Matches"
      expect(current_path).to eq(user_matches_path(@user))
    end
  end
end
