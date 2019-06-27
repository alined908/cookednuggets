# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

# Create Users
users = [
  ['Daniel', 'Lee', 'alined', 'daniel@berkeley.edu', 'password'],
  ['Billy', 'Bob', 'bigmacgal', 'billy@gmail.com', 'password'],
  ['Tiffany', 'Tsay', 'merci', 'tiff@berkeley.edu', 'password'],
  ['Joseph', 'Kim', 'campingfatkid', 'kyungrok@berkeley.edu', 'password']
]

users.each do |first, last, username, email, password|
  User.create(firstname: first, lastname: last, username: username,
              email: email, password: password, password_confirmation: password)
end

#Create Forum
forum_threads = [
  [1, 'OWL Postseason Trades', 'Which players should each OWL team pick up?'],
  [2, 'Best Gaming Mice?', 'What mouse do you think is the best to use?'],
  [4, 'Watch this streamer', "This dude sucks dick"]
]

forum_threads.each do |user_id, subject, description|
  ForumThread.create(user_id: user_id, subject: subject, description: description)
end

forum_posts = [
  [2, 1, "ForumThread", 1, 'The Fusion should pick up Alarm.'],
  [3, 1, "ForumThread", 1, 'Washington Justice need to replace Sansam.'],
  [4, 2, "ForumPost", 1, 'I agree with this statement'],
  [1, 3, "ForumPost", 1, 'I also agree with this statement'],
  [4, 1, "ForumPost", 1, "Alarm is a beast."],
  [3, 2, "ForumThread", 2, 'Best gaming mice I have used is Logitech G Pro Wireless'],
  [4, 6, "ForumPost", 2, 'I also use this mouse and its wireless feature is really good.'],
  [1, 3, "ForumThread", 3, 'Dont watch this streamer']
]

forum_posts.each do |user_id, parent_id, parent_type, thread_id, body|
  ForumPost.create(user_id: user_id, commentable_id: parent_id,
    commentable_type: parent_type, thread_id: thread_id, body: body)
end

#Create Events
events = [
  ["Overwatch League 2019", "Professional League for Overwatch", "Burbank, California", 5000000, Date.new(2019,1,1), Date.new(2019,7,15)]
]

events.each do |name, desc, location, prize, start, end_date|
  @event = Event.create(name: name, desc: desc, location: location, prize: prize, start_date: start, end_date: end_date)
end

#Create Teams
response = JSON.parse(open('https://api.overwatchleague.com/v2/teams').read)['data']
countries = {'DAL': 'us', 'PHI': 'us', 'HOU': 'us', 'BOS': 'us', 'NYE':'us', 'SFS':'us',
            'VAL': 'us', 'GLA': 'us', 'FLA': 'us', 'SHD': 'cn', 'SEO': 'kr', 'LDN': 'gb', 'PAR': 'fr',
            'CDH': 'cn', 'HZS': 'cn', 'TOR': 'ca', 'VAN': 'ca', 'WAS': 'us', 'ATL': 'us', 'GZC': 'cn'}
teams = {}
response.each do |team|
  socials = {}
  team['accounts'].each do |social|
    if social['type'] == "WEIBO"
      next
    end
    socials[social['type']] = social['url']
  end

  tem = Team.create(name: team['name'], shortname: team['abbreviatedName'], logo: team['logo']['main']['svg'],
          country: countries[team['abbreviatedName'].to_sym], socials: socials, website: team['website'])
  @event.teams << tem
  teams[tem.name] = tem.id
end

#Create Players
response = JSON.parse(open('https://api.overwatchleague.com/players').read)['content']
response.each do |player|
  socials = {}
  player['accounts'].each do |social|
    socials[social['accountType']] = social['value']
  end
  Player.create(headshot: player['headshot'], eng_name: player['givenName'] + " " + player['familyName'], handle: player['name'],
    country: player['nationality'], roles: [player['attributes']['role']], socials: socials, team_id: teams[player['teams'][0]['team']['name']])
end
