# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first_name: 'Wun', last_name: 'Yin', nickname: 'The Master', email: "wun@gmail.com")
User.create!(first_name: 'Jhonny', last_name: 'Yin', nickname: 'Mr Big Shot', email: "jhonny@gmail.com")
User.create!(first_name: 'David', last_name: 'Yin', nickname: 'Drunken Paddler', email: "david@gmail.com")
User.create!(first_name: 'Art', last_name: 'Rivkin', nickname: 'Angry Russian', email: "art@gmail.com")
User.create!(first_name: 'Abdul', last_name: 'Khader', nickname: 'Money', email: "abdul@gmail.com")

# Wun has 50 wins and 5 losses
wun = User.find_by_first_name('Wun')
opponents = User.where.not(first_name: 'Wun')
50.times do 
  Match.create(winner: wun, loser: opponents.sample)
end
5.times do 
  Match.create(winner: opponents.sample, loser: wun)
end

# Jhonny has 37 wins and 18 losses
jhonny = User.find_by_first_name('Jhonny')
opponents = User.where.not(first_name: 'Jhonny')
37.times do 
  Match.create(winner: jhonny, loser: opponents.sample)
end
18.times do 
  Match.create(winner: opponents.sample, loser: jhonny)
end

# David has 32 wins and 23 losses
david = User.find_by_first_name('David')
opponents = User.where.not(first_name: 'David')
32.times do 
  Match.create(winner: david, loser: opponents.sample)
end
23.times do 
  Match.create(winner: opponents.sample, loser: david)
end

# Art has 28 wins and 27 losses
art = User.find_by_first_name('Art')
opponents = User.where.not(first_name: 'Art')
28.times do 
  Match.create(winner: art, loser: opponents.sample)
end
27.times do 
  Match.create(winner: opponents.sample, loser: art)
end

# abdul has 20 wins and 35 losses
abdul = User.find_by_first_name('Abdul')
opponents = User.where.not(first_name: 'Abdul')
20.times do 
  Match.create(winner: abdul, loser: opponents.sample)
end
35.times do 
  Match.create(winner: opponents.sample, loser: abdul)
end