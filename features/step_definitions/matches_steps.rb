Given /^I create a match with map "(.*)" and left_team "(.*)" and right_team "(.*)"$/ do |map, left, right|
  page.fill_in "Date", :with => Date.today.strftime('%Y-%m-%d')
  fill_in 'Map', :with => map
  fill_in "Left Team", :with => left
  fill_in "Right Team", :with => right
  click_button "Submit"
end

Given /^a match with map "(.*)" and left_team "(.*)" and right_team "(.*)" exists$/ do |map, left, right|
  Match.create(:map => map, :left_team => left, :right_team => right, :date => Date.today.strftime('%Y-%m-%d'),
  :user_id => 1)
end

When /^I upload a composition csv$/ do
    attach_file('composition[composition_csv]', File.join(RAILS_ROOT, 'features', 'uploads', 'composition.csv'))
end

When /^I upload a general csv$/ do
    attach_file('general[general_csv]', File.join(RAILS_ROOT, 'features', 'uploads', 'general.csv'))
end

When /^I upload a fight csv$/ do
    attach_file('fight[fight_csv]', File.join(RAILS_ROOT, 'features', 'uploads', 'fight.csv'))
end
