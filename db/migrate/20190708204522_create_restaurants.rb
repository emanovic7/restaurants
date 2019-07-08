class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |r|
      r.string :name
      r.string :location
      r.string :cuisine
      r.float :rating
    end
  end
end
