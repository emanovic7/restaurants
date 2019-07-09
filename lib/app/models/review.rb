class Review < ActiveRecord::Base

  belongs_to :restaurant
  belongs_to :user 


  def restaurant
    restaurant = Restaurant.find(self.restaurant_id)
    return restaurant.name
  end

end
