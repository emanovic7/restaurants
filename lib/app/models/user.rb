require_relative '../../../config/environment'

class User < ActiveRecord::Base
  has_many :reservations
  has_many :restaurants, through: :reservations
  has_many :reviews

  def view_or_edit_reservations
    puts "Editting responses from User class"
    CommandLineInterface.prompt.select("Choose a reservation to edit.") do |menu|
      Reservation.all.each do |reservation|
        if reservation.user_id == self.id
          menu.choice "You have a reservation at #{reservation.restaurant.name} on #{reservation.date} at #{reservation.time}."
        end
      end
    end
  end
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
