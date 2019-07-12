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



end
