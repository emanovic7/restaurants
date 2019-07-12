Restaurant.destroy_all
User.destroy_all
Review.destroy_all
Reservation.destroy_all

#
# %w(SpongeBob MrKrabs HarryPotter EricCartman NotTrump).each do |name|
#   User.create(name: name)
# end
#
# %w(KrustyKrabs ShakeShack Chipotle).each do |restaurant_name|
#   Restaurant.create(name: restaurant_name)
# end
#


10.times do
  User.create(name: Faker::Name.name)
end


10.times do
  Restaurant.create(name: Faker::Company.name)
end


puts "done seeding :)"
