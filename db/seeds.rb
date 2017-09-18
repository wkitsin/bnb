# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = {}
user['password'] = 'asdf'
user['password_confirmation'] = 'asdf'

ActiveRecord::Base.transaction do
  20.times do 
    user['name'] = Faker::Name.name 
    user['email'] = Faker::Internet.email
    user['created_at'] = Faker::Date.between(2.days.ago, Date.today)
    user['updated_at'] = Faker::Date.between(2.days.ago, Date.today)
    byebug 
    User.create(user)
  end
end 