# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
