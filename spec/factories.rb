FactoryBot.define do
  factory :vote do
    user { nil }
    forum_post { nil }
  end

  factory :official do
    team1 { "MyString" }
    team2 { "MyString" }
    map_count { 1 }
    start { "2019-06-26 16:07:34" }
  end

  factory :event do
    name { "MyString" }
    desc { "MyString" }
    location { "MyString" }
    prize { 1 }
    start_date { "2019-06-26" }
    end_date { "2019-06-26" }
  end

  factory :player do
    eng_name { "MyString" }
    nat_name { "MyString" }
    country { "MyString" }
    age { 1 }
    role { "MyString" }
    social_stream { "MyString" }
    social_twitter { "MyString" }
    team { nil }
  end

  factory :team do
    name { "MyString" }
    country { "MyString" }
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end
  sequence :username do |n|
    "person#{n}"
  end

  factory :user do
    firstname {"Daniel"}
    lastname {"Lee"}
    username {generate(:username)}
    email {generate(:email)}
    password {"password"}
    password_confirmation {"password"}
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
    thread_id {1}

    trait :invalid do
      body {""}
    end
  end

  factory :match do
    date {Time.at(rand * Time.now.to_i)}
    left_team {"San Francisco Shock"}
    right_team {"Dallas Fuel"}
    map {"Rialto"}
    association :user
  end
end
