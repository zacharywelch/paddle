# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "Naruto Uzamaki", email: "nuzamaki@gmail.com")

9.times do |i|
  User.create(name: Faker::Name.name, email: "user-#{i+1}@gmail.com")
end

users = User.all
naruto = users.first
opponents = users[1..9]
opponents.each_with_index do |opponent, i| 
  winner = i.even? ? naruto : opponent
  loser  = i.even? ? opponent : naruto
  Match.create(winner: winner, loser: loser)
end