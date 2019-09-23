require 'spec_helper'

feature 'event creation' do
  scenario 'with valid attributes' do
    event_help
    fill_in 'event[shortname]', :with => 'OWL 2019'
    fill_in 'event[location]', :with => 'Burbank, California'
    fill_in 'event[start_date]', :with => "2019-05-30"
    fill_in 'event[end_date]', :with => "2019-10-30"
    fill_in 'event[prize]', :with => "1000000"
    click_link "Remove Team"
    click_button "Submit"
    expect(page).to have_content "Event successfully created"
    expect(page).to have_current_path(event_path(Event.last))
  end

  scenario 'with invalid attributes' do
    event_help
    click_button "Submit"
    expect(page).to have_current_path(events_path)
    page.should have_css('.alert-danger', :visible => true)
  end

  def event_help
    sign_in
    visit events_path
    click_link "Create Event"
    fill_in 'event[name]', :with => "Overwatch League 2019"
    click_link "Remove Team"
  end
end


feature 'section creation' do
  scenario 'with valid attributes' do
    section_help
    fill_in "section[name]", :with => "Stage 1"
    click_button "Submit", match: :first
    expect(page).to have_content "Section successfully created."
  end
  scenario 'with invalid attributes' do
    section_help
    click_button "Submit", match: :first
    page.should have_css('.alert-danger', :visible => true)
  end

  def section_help
    sign_in
    event = create(:event)
    visit event_path(event)
    click_link "Add Section"
    fill_in 'section[start]', :with => "2019-05-30"
    fill_in 'section[end]', :with => "2019-10-30"
  end
end

feature 'match creation' do
  scenario 'with valid attributes' do
    match_help
    fill_in 'official[start]', :with => Time.new(2018, 01, 02, 12)
    fill_in 'official[end]', :with => Time.new(2018, 01, 02, 13)
    within(:css, "#panel-2") do
      click_button "Submit"
    end
    expect(page).to have_content "Match successfully created."
  end
  scenario 'with invalid attributes' do
    match_help
    within(:css, "#panel-2") do
      click_button "Submit"
    end
    page.should have_css('.alert-danger', :visible => true)
  end

  def match_help
    sign_in
    section = create(:section, end: "2019-10-30")
    team1 = create(:team)
    team2 = create(:team)
    section.event.teams << [team1, team2]
    visit event_section_path(section.event, section)
    click_link "Add Match"
    select team1.name, :from => 'official[team1_id]'
    select team2.name, :from => 'official[team2_id]'
    fill_in 'official[match_type]', :with => "regular"
  end
end
