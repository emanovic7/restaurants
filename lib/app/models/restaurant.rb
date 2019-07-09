class Restaurant < ActiveRecord::Base
  has_many :reservations
  has_many :users, through: :reservations
  has_many :reviews

  def reservations
    Reservation.all.map do |reservation|
      if reservation.restaurant_id == self.id
        puts "#{reservation.date} - #{reservation.time}."
      end
    end
  end

   def reviews
     Review.all.map do |review|
       if review.restaurant_id == self.id
         puts "#{review.content}"
       end
     end
   end

   def avg_rating
     total_rating = 0
     Review.all.each do |review|
       if review.restaurant_id == self.id
         total_rating += review.rating
       end
     end

     return "#{self.name} has an average rating of #{total_rating/self.reviews.length}"
   end

   def make_reservation
     # puts "please select cuisine, or choose all:"
     # prompt.select("please select cuisine, or choose all:" ) do |menu|
     #   menu.choice 'McDonalds'
     #   menu.choice 'Chipotle'
     #   menu.choice 'Blossom'
     # end

     #ask for name
     #ask for date (09-12-19 Format)
     #ask for time
     puts "Please enter your name: "
     user_name = gets.chomp
     new_user = User.find_by(name: user_name)
     puts "For which date? "
     res_date = gets.chomp
     puts "at what time?"
     res_time = gets.chomp
     puts "for how many people?(1-7 people)"
     res_num = gets.chomp

     reservation = Reservation.create(user_id: new_user.id, restaurant_id: self.id, time: res_time, date: res_date, number_of_people: res_num )

     puts "You have just made a reservation for #{reservation.restaurant.name}"
     puts "on #{reservation.date}"
     puts "at #{reservation.time}"
     puts "for #{reservation.number_of_people} person(s)"
   end



end
