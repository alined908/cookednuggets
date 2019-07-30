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
  ['Daniel', 'Lee', 'alined', 'daniel@berkeley.edu', 'password', 'us'],
  ['Billy', 'Bob', 'bigmacgal', 'billy@gmail.com', 'password', 'us'],
  ['Tiffany', 'Tsay', 'merci', 'tiff@berkeley.edu', 'password', 'cn'],
  ['Joseph', 'Kim', 'campingfatkid', 'kyungrok@berkeley.edu', 'password', 'kr']
]

users.each do |first, last, username, email, password, country|
  User.create(firstname: first, lastname: last, username: username, country: country,
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

#Create Events
events = [
  ["us", "Overwatch League 2019", "Professional League for Overwatch", "Burbank, California", 5000000, Date.new(2019,1,1), Date.new(2019,9,29)],
  ["us", "Overwatch Contenders 2019 Season 2: North America", "Contenders North America", "Online", 100000, Date.new(2019, 6, 12), Date.new(2019, 8, 30)],
  ["kr", "Overwatch Contenders 2019 Season 2: Korea", "Contenders Korea", "Online", 100000, Date.new(2019, 6, 12), Date.new(2019, 8, 30)],
  ["cn", "Overwatch Contenders 2019 Season 2: China", "Contenders China", "Online", 100000, Date.new(2019, 6, 12), Date.new(2019, 8, 30)]
]

events.each do |country, name, desc, location, prize, start, end_date|
  Event.create(name: name, desc: desc, location: location, prize: prize, start_date: start, end_date: end_date, country: country)
end

@event = Event.first
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

#Create Sections
sections = [
  [1, "Stage 1", Date.new(2019, 2, 14), Date.new(2019, 3, 24)],
  [1, "Stage 2", Date.new(2019, 4, 4), Date.new(2019, 5, 12)],
  [1, "Stage 3", Date.new(2019, 6, 7), Date.new(2019, 7, 7)],
  [1, "Stage 4", Date.new(2019, 7, 25), Date.new(2019, 8, 25)],
  [1, "Playoffs", Date.new(2019, 8, 31), Date.new(2019, 9, 30)]
]

sections.each do |event, name, start, ends|
  Section.create(event_id: event, name: name, start: start, end: ends)
end

owl_teams = {}
Team.all.each do |team|
  owl_teams[team.name] = team
end

i = 0
#Create Matches
response = JSON.parse(open("https://api.overwatchleague.com/schedule").read)['data']
# Stages
response['stages'].each do |stage|
  next if !(stage['name'].include? "Stage")
  # Matches
  i += 1
  stage['matches'].each do |match|
    next if match['competitors'].include?(nil)
    team1 = owl_teams[match['competitors'][0]['name']].id
    team2 = owl_teams[match['competitors'][1]['name']].id
    start = match['startDate']
    ends = match['endDate']
    score = match['wins']
    match.key?('winner') ? (winner = owl_teams[match['winner']['name']].id) : (winner = nil)
    (match['tournament']['type'] == "OPEN_MATCHES") ? (match_type = "regular") : (match_type = "playoff")

    official = Official.create(match_type: match_type, section_id: i, team1_id: team1, team2_id: team2,
        winner_id: winner, start: start, end: ends, score: score, identifier: match['id'], event_id: @event.id)
    # Maps
    match['games'].each do |map|
      if !map.key?('points')
        map_winner = nil
        state = 'unstarted'
        score = []
        map_name = nil
      else
        score = map['points']
        state = 'concluded'
        map_name = map['attributes']['map']
        if map['points'][0] > map['points'][1]
          map_winner = team1
        elsif map['points'][0] < map['points'][1]
          map_winner = team2
        else
          map_winner = 0
        end
      end
      Map.create(official_id: official.id, winner_id: map_winner, name: map_name, state: state, score: score)
    end
  end
end

response = JSON.parse(open("https://api.overwatchleague.com/matches").read)['content']

response.each do |match|
  official = Official.find_by(identifier: match['id'].to_i)
  next if official == nil
  comps = match['competitors']
  ids = {comps[0]['id'] => Team.find_by(name: comps[0]['name']), comps[1]['id'] => Team.find_by(name: comps[1]['name'])}

  match['games'].each_with_index do |map, index|
    map_db = official.maps[index]
    map['players'].each do |player|
      team = player['team']['id']
      player_db = Player.find_by(handle: player['player']['name'])
      next if player_db == nil
      puts player['player']['name']
      perf = Performance.create(player_id: player_db.id, map_id: map_db.id, team_id: ids[team].id)
      map_db.performances << perf
    end
  end
end

forum_posts = [
  [2, 1, "ForumThread", 1, 'The Fusion should pick up Alarm.'],
  [3, 1, "ForumThread", 1, 'Washington Justice need to replace Sansam.'],
  [4, 2, "ForumPost", 1, 'I agree with this statement'],
  [1, 3, "ForumPost", 1, 'I also agree with this statement'],
  [4, 1, "ForumPost", 1, "Alarm is a beast."],
  [3, 2, "ForumThread", 2, 'Best gaming mice I have used is Logitech G Pro Wireless'],
  [4, 6, "ForumPost", 2, 'I also use this mouse and its wireless feature is really good.'],
  [1, 3, "ForumThread", 3, 'Dont watch this streamer'],
  [1, 1, "Official", nil , "Wow Carpe popped off"]
]

forum_posts.each do |user_id, parent_id, parent_type, thread_id, body|
  ForumPost.create(user_id: user_id, commentable_id: parent_id,
    commentable_type: parent_type, thread_id: thread_id, body: body)
end
