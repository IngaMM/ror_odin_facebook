10.times do |n|
  email = "user#{n+1}@test.org"
  password = "foobar"
  User.create!(email: email,
               password:              password,
               password_confirmation: password)
end


5.times do |n|
  email = "user#{n+1}@test.org"
  user = User.find_by_email(email)
  user.sent_friendrequests.create!(receiver_id: user.id+1)
  user.sent_friendrequests.create!(receiver_id: user.id+2)
  user.sent_friendrequests.create!(receiver_id: user.id+3)
  user.friendships.create!(befriended_id: user.id+4)
  user.friendships.create!(befriended_id: user.id+5)
  user.posts.create!(content: Faker::Quote.famous_last_words)
  user.posts.create!(content: Faker::Quote.famous_last_words)
  user.posts.create!(content: Faker::Quote.famous_last_words)
end

posts = Post.all
posts.each do |post|
  number_comments = rand(5)
  number_comments.times do
    user_id = rand(1..10)
    post.comments.create!(user_id: user_id, content: Faker::Quote.famous_last_words)
  end
  number_likes = rand(20)
  number_likes.times do
    post.likes.create!
  end
end
