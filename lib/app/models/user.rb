

class User < ActiveRecord::Base
  has_many :reservations
  has_many :restaurants, through: :reservations
  has_many :reviews


  # def make_reservation
  #   # puts "please select cuisine, or choose all:"
  #   # prompt.select("please select cuisine, or choose all:" ) do |menu|
  #   #   menu.choice 'McDonalds'
  #   #   menu.choice 'Chipotle'
  #   #   menu.choice 'Blossom'
  #   # end
  #
  #   #ask for name
  #   #ask for date (09-12-19 Format)
  #   #ask for time
  #   puts "Please enter your name: "
  #   user_input = gets.chomp
  #   new_restaurant = Restaurant.find_by(name: restaurant.name)
  #   reservation = Reservation.create(user_id: self.id, restaurant_id: new_restaurant.id)
  # end


end
