# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

puts "users"
# Create Users
users = [
  ['Daniel', 'Lee', 'alined', 'daniel@berkeley.edu', 'password', 'us', 2],
  ['Billy', 'Bob', 'bigmacgal', 'billy@gmail.com', 'password', 'us', 1],
  ['Tiffany', 'Tsay', 'merci', 'tiff@berkeley.edu', 'password', 'cn', 0],
  ['Joseph', 'Kim', 'campingfatkid', 'kyungrok@berkeley.edu', 'password', 'kr', 0]
]

users.each do |first, last, username, email, password, country, role|
  User.create(firstname: first, lastname: last, username: username, country: country,
              email: email, password: password, password_confirmation: password, role: role)
end

puts "forum-threads"
#Create Forum
forum_threads = [
  [1, 'OWL Postseason Trades', 'Which players should each OWL team pick up?'],
  [2, 'Best Gaming Mice?', 'What mouse do you think is the best to use?'],
  [4, 'Watch this streamer', "This dude sucks dick"]
]

forum_threads.each do |user_id, subject, description|
  ForumThread.create(user_id: user_id, subject: subject, description: description)
end

puts "events"
#Create Events
events = [
  ["us", "Overwatch League 2019", "Professional League for Overwatch", "Burbank, California", 5000000, Date.new(2019,1,1), Date.new(2019,9,29), "OWL 2019", "#f08242", true, true],
  ["us", "Overwatch Contenders 2019 Season 2: North America", "Contenders North America", "Online", 100000, Date.new(2019, 6, 12), Date.new(2019, 8, 30), "OWC 2019 S2:NA", "#13bf82", false, false],
  ["kr", "Overwatch Contenders 2019 Season 2: Korea", "Contenders Korea", "Online", 100000, Date.new(2019, 6, 12), Date.new(2019, 8, 30), "OWC 2019 S2:KR", "#0bb8da", false, false],
  ["cn", "Overwatch Contenders 2019 Season 2: China", "Contenders China", "Online", 100000, Date.new(2019, 6, 12), Date.new(2019, 8, 30), "OWC 2019 S2:CN", "#aa76b3", false, false]
]

events.each do |country, name, desc, location, prize, start, end_date, shortname, color, display, primary|
  Event.create(name: name, desc: desc, location: location, prize: prize, start_date: start,
    end_date: end_date, country: country, shortname: shortname, color: color, display_ranking: display, primary_ranking: primary)
end

puts "teams"
@event = Event.first
#Create Teams
response = JSON.parse(open('https://api.overwatchleague.com/v2/teams').read)['data']
countries = {'DAL': 'us', 'PHI': 'us', 'HOU': 'us', 'BOS': 'us', 'NYE':'us', 'SFS':'us',
            'VAL': 'us', 'GLA': 'us', 'FLA': 'us', 'SHD': 'cn', 'SEO': 'kr', 'LDN': 'gb', 'PAR': 'fr',
            'CDH': 'cn', 'HZS': 'cn', 'TOR': 'ca', 'VAN': 'ca', 'WAS': 'us', 'ATL': 'us', 'GZC': 'cn'}
players ={}
response.each do |team|
  team['players'].each do |player|
    players[player['name']] = team['name']
  end
end
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

puts "players"
#Create Players
response = JSON.parse(open('https://api.overwatchleague.com/players').read)['content']
response.each do |player|
  socials = {}
  player['accounts'].each do |social|
    socials[social['accountType']] = social['value']
  end
  Player.create(headshot: player['headshot'], eng_name: player['givenName'] + " " + player['familyName'], handle: player['name'],
    country: player['nationality'], roles: player['attributes']['role'], socials: socials, team_id: teams[players[player['name']]])
end

#Create Sections
sections = [
  [1, "Stage 1", Date.new(2019, 2, 14), Date.new(2019, 3, 24)],
  [1, "Stage 2", Date.new(2019, 4, 4), Date.new(2019, 5, 12)],
  [1, "Stage 3", Date.new(2019, 6, 7), Date.new(2019, 7, 7)],
  [1, "Stage 4", Date.new(2019, 7, 25), Date.new(2019, 8, 25)],
  [1, "Playoffs", Date.new(2019, 8, 31), Date.new(2019, 9, 30)]
]
puts "sections"

sections.each do |event, name, start, ends|
  Section.create(event_id: event, name: name, start: start, end: ends)
end

owl_teams = {}
Team.all.each do |team|
  owl_teams[team.name] = team
end
puts "maps"
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
    if match['games'].length == 0
      games = 4
    else
      games = match['games'].length
    end

    official = Official.create(match_type: match_type, section_id: i, team1_id: team1, team2_id: team2,
        winner_id: winner, start: start, end: ends, score: score, map_count: games, identifier: match['id'], event_id: @event.id)
    # Maps
    match['games'].each do |map|
      if !map.key?('points')
        map_winner = nil
        state = 'unfinished'
        score = []
        map_name = nil
      else
        score = map['points']
        state = 'finished'
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
puts "performance"
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

news = [
  [1, "Coach815 leaves the Spitfire", "kr", 1.day.ago],
  [4, "Munchkin departs from Seoul Dynasty", "kr", 2.days.ago],
  [1, "Blizzard announces 2-2-2 role lock", "un", 3.days.ago],
  [3, "New Hero: Sigma", "un", 8.days.ago],
  [4, "Alarm promoted to Fusion main roster", "kr", 2.weeks.ago],
  [2, "Defiant pick up Mangachu", "ca", 3.weeks.ago],
  [1, "CampingFatKid: An Inside Look", "us", 4.weeks.ago],
  [1, "Alined and Mercy leave Shock", "us", 2.months.ago],
  [3, "Leave joins Hunters as contracted talent", "cn", 1.week.ago]
]

news.each do |author, subject, country, article, created_at|
  New.create(user_id: author, subject: subject, country: country,
    article: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ")
end

news.each_with_index do |attr, index|
  article = New.find(index + 1)
  article.created_at = attr[3]
  article.save!
end

featured = New.create(user_id: 2, subject: "Featured Article Title", country: "us", article: "<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a</p>", featured: true)
featured.avatar.attach(io: File.open('app/assets/images/misc/owl.jpg'), filename: "owl.jpg")

forum_posts = [
  [2, 1, "ForumThread", 1, '<p>The Fusion should pick up Alarm.</p>'],
  [3, 1, "ForumThread", 1, '<p>Washington Justice need to replace Sansam.</p>'],
  [4, 2, "ForumPost", 1, '<p>I agree with this statement</p>'],
  [1, 3, "ForumPost", 1, '<p>I also agree with this statement</p>'],
  [4, 1, "ForumPost", 1, "<p>Alarm is a beast.</p>"],
  [3, 2, "ForumThread", 2, '<p>Best gaming mice I have used is Logitech G Pro Wireless</p>'],
  [4, 6, "ForumPost", 2, '<p>I also use this mouse and its wireless feature is really good.</p>'],
  [1, 3, "ForumThread", 3, '<p>Dont watch this streamer</p>'],
  [1, 1, "Official", nil , "<p>Wow Carpe popped off</p>"],
  [1, 1, "New", nil , "<p>Sad that he has to go</p>"],
  [3, 2, "New", nil , "<p>His widow was the best in comp</p>"],
  [1, 3, "New", nil , "<p>Finally some exciting games</p>"],
  [2, 3, "New", nil , "<p>LUL FINALLY</p>"],
  [4, 6, "New", nil , "<p>Mangachu is he good?</p>"],
  [1, 7, "New", nil , "<p>TRASH MASTERS PLAYER</p>"]
]

forum_posts.each do |user_id, parent_id, parent_type, thread_id, body|
  ForumPost.create(user_id: user_id, commentable_id: parent_id,
    commentable_type: parent_type, thread_id: thread_id, body: body)
end

Official.create(team1_id: 17, team2_id: 6, winner_id: nil,
  identifier: nil, comments_count: 0, map_count: 4,
  label: nil, score: [0, 0], match_type: "Quarterfinals",
  start: 1.day.from_now, end: 2.days.from_now,
  section_id: 5, event_id: 1, subject: "VAN vs SFS - Overwatch League 2019 Playoffs")
