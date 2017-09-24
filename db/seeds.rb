# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed Users
# user = {}
# user['password'] = 'asdf'


# ActiveRecord::Base.transaction do
#   20.times do 
#     user['name'] = Faker::Name.name 
#     user['email'] = Faker::Internet.email
#     user['created_at'] = Faker::Date.between(2.days.ago, Date.today)
#     user['updated_at'] = Faker::Date.between(2.days.ago, Date.today)
#     byebug 
#     User.create(user)
#   end
# end 

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  40.times do 
    listing['type_of_room'] = ["Private Room", "Shared Room", "Entire Place"].sample 
    listing['category'] = ["smoker", "non-smoker", "pet"].sample
    listing['number_of_guest'] = rand(1..10)

    listing['location'] = Faker::Address.country

    listing['price'] = rand(80..500)
    listing['title'] = Faker::Hipster.sentence

    listing['user_id'] = uids.sample

    Listing.create(listing)
  end
end
