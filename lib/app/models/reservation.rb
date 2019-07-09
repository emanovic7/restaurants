class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  def update_reservation

  end
end
