class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |r|
      r.string :date
      r.string :time
      r.integer :number_of_people
      r.boolean :visited
      
      r.integer :user_id
      r.integer :restaurant_id
    end
  end
end
