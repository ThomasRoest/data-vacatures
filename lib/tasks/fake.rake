namespace :db do   #use --> bundle exec rake db:populate
  desc "Fill database with sample data"
  task populate: :environment do
      #make_users
      make_posts
     #make_relationships
     #make_resources
  end
end

# def make_users
#   admin = User.create!(name:     "Hospitality Hangout!",
#                        email:    "contact@hospitalityhangout.com",
#                        password: "test123",
#                        password_confirmation: "test123",
#                        admin: true)
#   50.times do |n|
#     name  = Faker::Name.name
#     email = "example-#{n+1}@railstutorial.org"
#     password  = "password"
#     User.create!(name:     name,
#                  email:    email,
#                  password: password,
#                  password_confirmation: password)
#   end
# end

 def make_posts
  # users = User.all(limit: 6)
   40.times do
     title = Faker::Lorem.sentences(1)
     content = Faker::Lorem.sentences(1)
     topic_id = rand(1)
     user_id = rand(5..10)
     # users.each { |user| user.posts.create!(title: title, content: content, topic_id: topic_id) }
   end
 end

 # def make_relationships
 #   users = User.all
 #   user  = users.first
 #   followed_users = users[2..50]
 #   followers      = users[3..40]
 #   followed_users.each { |followed| user.follow!(followed) }
 #   followers.each      { |follower| follower.follow!(user) }
 # end


 # def make_resources
 #  users = User.all(limit: 10)
 #  20.times do
 #    title = Faker::Company.catch_phrase
 #    description = Faker::Lorem.paragraph
 #    link = Faker::Internet.url
 #    category = Faker::Commerce.department
 # #    users.each { |user| user.resources.create!(title: title, description: description, link: link, category: category) }
 # #  end
# end

 