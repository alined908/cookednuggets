# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  ['Daniel', 'Lee', 'alined', 'daniel@berkeley.edu', 'password'],
  ['Billy', 'Bob', 'bigmacgal', 'billy@gmail.com', 'password']
]

users.each do |first, last, username, email, password|
  User.create(firstname: first, lastname: last, username: username,
              email: email, password: password, password_confirmation: password)
end

forum_threads = [
  [1, 'OWL Postseason Trades', 'Which players should each OWL team pick up?'],
  [2, 'Best Gaming Mice?', 'What mouse do you think is the best to use?']
]

forum_threads.each do |user_id, subject, description|
  ForumThread.create(user_id: user_id, subject: subject, description: description)
end

forum_posts = [
  [2, 1, 'The Fusion should pick up Alarm.']
]
