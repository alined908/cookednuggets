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
    team2 {team1}
    association :event
    association :section
    match_type {"Regular"}
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

  factory :vote do
    user { nil }
    forum_post { nil }
  end

  factory :player do
    eng_name { "MyString" }
    nat_name { "MyString" }
    country { "MyString" }
    age { 1 }
    role { "MyString" }
    social_stream { "MyString" }
    social_twitter { "MyString" }
    association :team
  end
end
