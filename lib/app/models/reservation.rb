class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant


  # def view_reservation
  #   puts "You have a reservation at #{self.restaurant.name} on #{self.date} at #{self.time} for #{self.number_of_people}."
  #   @prompt.select("Do you want to :") do |menu|
  #     menu.choice "edit", -> {update_reservation}
  #     menu.choice "delete", -> {"delete reservation"}
  #   end
  # end
  #
  # def update_reservation
  #
  #   puts "Type in the new date."
  #   new_date = gets.chomp
  #   self.update(self.id, date: new_date)
  #   puts "You have a reservation at #{self.restaurant.name} on #{self.date} at #{self.time}."
  # end
end
