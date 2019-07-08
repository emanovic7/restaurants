Restaurant.destroy_all
User.destroy_all
Reservation.destroy_all


%w(SpongeBob MrKrabs HarryPotter EricCartman NotTrump).each do |name|
  User.create(name: name)
end

%w(KrustyKrabs ShakeShack Chipotle).each do |restaurant_name|
  Restaurant.create(name: restaurant_name)
end

res1 = Reservation.create(user_id: 4, restaurant_id: 3)
res2 = Reservation.create(user_id: 2, restaurant_id: 1)
res3 = Reservation.create(user_id: 3, restaurant_id: 3)
res4 = Reservation.create(user_id: 2, restaurant_id: 2)
res5 = Reservation.create(user_id: 2, restaurant_id: 1)
res6 = Reservation.create(user_id: 5, restaurant_id: 1)




puts "done seeding :)"
