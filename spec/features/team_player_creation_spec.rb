require 'spec_helper'

feature 'player creation' do
  scenario 'with valid attributes' do
    team = create(:team)
    sign_in
    visit players_path
    page.should have_css('.admin-panel', :visible => true)
    page.should have_css('#new_player', :visible => false)
    click_link 'Create Player'
    page.should have_css('#new_player', :visible => true)
    fill_in 'player[eng_name]', :with => 'Daniel Lee'
    fill_in 'player[nat_name]', :with => 'Daniel Lee'
    fill_in 'player[handle]', :with => 'Alined'
    fill_in 'player[roles]', :with => 'offtank'
    fill_in 'player[socials][DISCORD]', :with => 'discord.gg/sfs'
    select team.name, :from => 'player[team_id]'
    click_button 'Submit'
    expect(page).to have_content "Player successfully created"
  end

  scenario 'with invalid attributes' do
    team = create(:team)
    sign_in
    visit players_path
    click_link 'Create Player'
    fill_in 'player[eng_name]', :with => 'Daniel Lee'
    fill_in 'player[nat_name]', :with => 'Daniel Lee'
    fill_in 'player[roles]', :with => 'offtank'
    fill_in 'player[socials][DISCORD]', :with => 'discord.gg/sfs'
    select team.name, :from => 'player[team_id]'
    click_button 'Submit'
    expect(page).to have_current_path(players_path)
  end
end

feature 'team creation' do
  scenario 'with valid attributes' do
    player = create(:player)
    sign_in
    visit teams_path
    page.should have_css('.admin-panel', :visible => true)
    page.should have_css('#new_team', :visible => false)
    click_link 'Create Team'
    page.should have_css('#new_team', :visible => true)
    fill_in 'team[name]', :with => 'SF Shock'
    fill_in 'team[shortname]', :with => 'SFS'
    select player.handle, :from => 'players[]'
    click_button 'Submit'
    expect(page).to have_content "Team successfully created"
    expect(Team.last.players.first).to eq(player)
  end

  scenario 'with invalid attributes' do
    player = create(:player)
    sign_in
    visit teams_path
    click_link 'Create Team'
    fill_in 'team[shortname]', :with => 'SFS'
    select player.handle, :from => 'players[]'
    click_button 'Submit'
    expect(page).to have_current_path(teams_path)
    page.should have_css('.alert-danger', :visible => true)
  end
end
