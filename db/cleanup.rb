user = User.find_by_first_name("Dennis")
user = User.find_by_first_name_and_last_name("Zac", "North")
user.points = 1450
user.win_count = 0
user.loss_count = 0
user.save

jhonny = User.find_by_first_name("Jhonny")
david  = User.find_by_first_name("David")
dennis = User.find_by_first_name("dennis")
art    = User.find_by_first_name("Art")

Match.create!(winner: art, loser: jhonny)
Match.create!(winner: dennis, loser: art)
Match.create!(winner: david, loser: jhonny)
