FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
  sequence :username do |n|
    "person#{n}"
  end

  sequence :teamname do |n|
    "team #{n}"
  end

  factory :new do
    association :user
    subject {"Subject"}
    article {"article"}
  end

  factory :official do
    association :team1, factory: :team
    association :team2, factory: :team
    association :event
    association :section
    match_type {"regular"}
    start { "2019-06-26 16:07:34" }
  end

  factory :event do
    name {"Overwatch League"}
    shortname {"OWL"}
    desc {"Pro League"}
    location { "Burbank, California" }
    prize { 1 }
    start_date { "2019-06-26" }
    end_date { "2019-10-26" }
  end

  factory :section do
    association :event
    name {"Stage 1"}
    start {"2019-07-30"}
  end

  factory :team do
    name {generate(:teamname)}
    shortname {generate(:teamname)}
    socials {{"TWITTER" => "twitter.com/sfs", "DISCORD" => "discord.gg/sfs"}}
  end

  factory :user do
    firstname {"Daniel"}
    lastname {"Lee"}
    username {generate(:username)}
    email {generate(:email)}
    password {"password"}
    password_confirmation {"password"}
    country {"us"}
    role {2}
  end

  factory :forum_thread do
    association :user
    subject {"OWL Predictions"}
    description {"What are your predictions?"}
  end

  factory :forum_post do
    association :user
    commentable_id {1}
    commentable_type {"ForumThread"}
    body {"Florida Mayhem 28-0"}
  end

  factory :performance do
    association :map
    association :team
    association :player
  end

  factory :map do
    association :official
  end

  factory :vote do
    association :user
    votable_id {1}
    votable_type {"ForumPost"}
    direction {1}
  end

  factory :player do
    association :team
    handle {"daw"}
    eng_name { "MyString" }
    nat_name { "MyString" }
    roles {"dps"}
    team_id {1}
    socials {{"TWITTER" => "twitter.com/alined", "DISCORD" => "discord.gg/alined"}}
  end
end
