

class User < ActiveRecord::Base
  has_many :reservations
  has_many :restaurants, through: :reservations
  has_many :reviews



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

  

end
