FactoryBot.define do
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
