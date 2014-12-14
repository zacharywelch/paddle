# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

wun    = User.create!(first_name: 'Wun', last_name: 'Yin', nickname: 'The Master', email: "wun@gmail.com", password: "password", password_confirmation: "password")
jhonny = User.create!(first_name: 'Jhonny', last_name: 'Yin', nickname: 'Mr Big Shot', email: "jhonny@gmail.com", password: "password", password_confirmation: "password")
david  = User.create!(first_name: 'David', last_name: 'Yin', nickname: 'Drunken Paddler', email: "david@gmail.com", password: "password", password_confirmation: "password")
art    = User.create!(first_name: 'Art', last_name: 'Rivkin', nickname: 'Angry Russian', email: "art@gmail.com", password: "password", password_confirmation: "password")
abdul  = User.create!(first_name: 'Abdul', last_name: 'Khader', nickname: 'Money', email: "abdul@gmail.com", password: "password", password_confirmation: "password")

# Wun's record
# 10-2 vs jhonny
# 9-1 vs david
# 13-0 vs art
# 15-0 vs abdul
10.times { Match.create!(winner: wun, loser: jhonny) }
2.times  { Match.create!(winner: jhonny, loser: wun) }
9.times  { Match.create!(winner: wun, loser: david) }
1.times  { Match.create!(winner: david, loser: wun) }
13.times { Match.create!(winner: wun, loser: art) }
15.times { Match.create!(winner: wun, loser: abdul) }

# Jhonny's record 
# 3-3 vs david
# 9-3 wins vs art
# 10-1 wins vs abdul
3.times  { Match.create!(winner: jhonny, loser: david) }
3.times  { Match.create!(winner: david, loser: jhonny) }
9.times  { Match.create!(winner: jhonny, loser: art) }
3.times  { Match.create!(winner: art, loser: jhonny) }
10.times { Match.create!(winner: jhonny, loser: abdul) }
1.times  { Match.create!(winner: abdul, loser: jhonny) }

# David's record 
# 10-5 vs art
# 12-1 vs abdul
10.times { Match.create!(winner: david, loser: art) }
5.times  { Match.create!(winner: art, loser: david) }
12.times { Match.create!(winner: david, loser: abdul) }
1.times  { Match.create!(winner: abdul, loser: david) }

# Art's record 
# 10-3 vs abdul
10.times { Match.create!(winner: art, loser: abdul) }
3.times { Match.create!(winner: abdul, loser: art) }