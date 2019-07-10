require_relative '../../../config/environment'

class User < ActiveRecord::Base
  has_many :reservations
  has_many :restaurants, through: :reservations
  has_many :reviews

  def view_reservation

    puts "You have a reservation at #{reservation.restaurant.name} on #{reservation.date} at #{reservation.time} for #{reservation.number_of_people}."
    @prompt.select("Do you want to :") do |menu|
      menu.choice "edit", -> {update_reservation}
      menu.choice "delete", -> {"delete reservation"}
    end
  end

  def update_reservation
    # reservation = self.reservations.select do |reservation|
    #   reservation.id == self.id
    puts "#{reservation}"
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

  def reservations
    Reservation.all.map do |reservation|
        if reservation.user_id == self.id
          puts "#{reservation.restaurant.name} - #{reservation.date} at #{reservation.time}"
        end
    end
  end
  # self.reservations.all.each_with_index(1) do |reservation, i|


  def reviews
    Review.all.map do |review|
      if review.user_id == self.id
        puts "Review: #{review.content}"
        puts "for: #{review.restaurant}"
        puts "rating: #{review.rating}"
      end
    end
  end


  def edit_reservation
    "edit"
  end


# end
