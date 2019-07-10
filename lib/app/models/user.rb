require_relative '../../../config/environment'

class User < ActiveRecord::Base
  has_many :reservations
  has_many :restaurants, through: :reservations
  has_many :reviews

  def view_reservation
    reservation = self.reservations.select do |reservation|
      reservation.id == self.id
      binding.pry
    end

    puts "You have a reservation at #{reservation.restaurant.name} on #{reservation.date} at #{reservation.time} for #{reservation.number_of_people}."
    @prompt.select("Do you want to :") do |menu|
      menu.choice "edit", -> {update_reservation}
      menu.choice "delete", -> {"delete reservation"}
    end
  end

  def update_reservation

    puts "Type in the new date."
    new_date = gets.chomp
    self.update(self.id, date: new_date)
    puts "You have a reservation at #{self.restaurant.name} on #{self.date} at #{self.time}."
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


# end
