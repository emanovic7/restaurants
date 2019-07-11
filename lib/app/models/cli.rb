class CommandLineInterface


  def initialize
    @prompt = TTY::Prompt.new
    @font = TTY::Font.new(:doom)
    @user = nil
    @reservation = nil
    @restaurant = nil
    @review = nil
    @pastel = Pastel.new
  end

    ###############################USER METHODS#######################################
    def new_user

      puts "Please enter your name: "
      user_input = gets.chomp
      new_user = User.create(name: user_input)
      puts "Welcome to Make Res, #{new_user.name}"
      @user = new_user

      choices
    end

    def returning_user

      puts "Please enter your name: "
      user_input = gets.chomp
      ret_user = User.find_by(name: user_input)
        if ret_user == nil
          puts "user name not found, please try again or create an account"
          greeting_prompt
        else
          puts "Welcome back, #{ret_user.name}!"
          choices
        end
        @user = ret_user
    end

    def view_all_reservations
      puts `clear`
      if @user.reservations.length == 0
        @prompt.select("You have no reservations at this time, would you like to make one?") do |menu|
          menu.choice "yes", -> { select_restaurant }
          menu.choice "no", -> { choices }
        end
     end

      @prompt.select("Here are your reservations") do |menu|
        Reservation.all.map do |reservation|
          # @reservation = reservation
          if reservation.user_id == @user.id
            menu.choice "#{reservation.restaurant.name} - #{reservation.time}", -> { view_reservation(reservation) }
          end
        end
        menu.choice "back", -> { choices }
      end

   end

   def view_favorite_restaurants
     puts `clear`
     restaurant = nil
     review_array = Review.where(user_id: user_id = @user.id).where(rating: rating = 5)

     if review_array.length == 0
       puts "you haven't rated any restaurants 5 stars you grouch"
     else
       puts "These are the restaurants you've rated 5 stars or more"
       review_array.map do |review|
         restaurant = Restaurant.find(review.restaurant_id)
         puts restaurant.name
       end
     end
     choices
   end



    ##########################RESTAURANT METHODS#############################
    #SELECT
    def select_restaurant
      puts `clear`
      @prompt.select("pick a restaurant") do |menu|
        Restaurant.all.map do |restaurant|
          # @restaurant = restaurant
          menu.choice restaurant.name, -> { reserve_or_review(restaurant.name) }
        end
        menu.choice "back", -> { choices }
      end
    end

    def reserve_or_review(restaurant_name)
      @restaurant = Restaurant.find_by(name: restaurant_name)
      @prompt.select("Would you like to reserve or leave a review for this restaurant?") do |menu|
        menu.choice "Make a reservation", -> { make_reservation }
        menu.choice "Leave a review", -> { write_review }
      end
    end

    #MAKE RESERVATION
    def make_reservation
      puts `clear`
      #ask for name
      #ask for date (09-12-19 Format)
      #ask for time
      # puts "Please enter your name: "
      # user_name = gets.chomp
      # new_user = User.find_by(name: user_name)
      puts "You are making a reservation at #{@restaurant.name}:"
      puts "For which date? "
      res_date = gets.chomp
      puts "at what time?"
      res_time = gets.chomp
      puts "for how many people?(1-7 people)"
      res_num = gets.chomp

      reservation = Reservation.create(user_id: @user.id, restaurant_id: @restaurant.id, time: res_time, date: res_date, number_of_people: res_num )

      puts "You have just made a reservation at #{reservation.restaurant.name}"
      puts "on #{reservation.date}"
      puts "at #{reservation.time}"
      puts "for #{reservation.number_of_people} person(s)"

      choices
    end

    #VIEW
    def view_reservation(reservation)
      puts `clear`
      @reservation = reservation
       puts "You have a reservation
       at #{@reservation.restaurant.name}
       on #{@reservation.date}
       at #{@reservation.time}
       for #{@reservation.number_of_people} people!"


        @prompt.select("You can :") do |menu|
          menu.choice "edit reservation", -> { update_reservation }
          menu.choice "delete reservation", -> { delete_reservation }
          menu.choice "back", -> { view_all_reservations }
        end
    end


    #DELETE
    def delete_reservation
      puts `clear`
      @prompt.select("are you sure?") do |menu|
        menu.choice "yes", -> { @reservation.destroy }
        menu.choice "no", -> { view_reservation(@reservation) }
      end
      view_all_reservations
    end


    #UPDATE
    def update_reservation
      puts `clear`
      @prompt.select("What would you like to change?") do |menu|
        menu.choice 'I want to change the date', -> { change_date }
        menu.choice 'I want to change the time', -> { change_time }
        menu.choice 'I want to change the number of people in my party', -> { change_num_people }
      end
    end

    def change_date
      puts `clear`
      puts "When would you like to change the date to?"
      new_date = gets.chomp
      @reservation.update(date: new_date)
      puts "Your reservation now is
      at #{@reservation.restaurant.name}
      on #{@reservation.date}
      at #{@reservation.time}
      for #{@reservation.number_of_people} people!"
      view_all_reservations
    end

    def change_time
      puts `clear`
      puts "When would you like to change the time to?"
      new_time = gets.chomp
      @reservation.update(time: new_time)
      puts "Your reservation now is
      at #{@reservation.restaurant.name}
      on #{@reservation.date}
      at #{@reservation.time}
      for #{@reservation.number_of_people} people!"
      view_all_reservations
    end

    def change_num_people
      puts `clear`
      puts "When would you like to change the number of people in your party to?"
      new_num = gets.chomp
      @reservation.update(number_of_people: new_num)
      puts "Your reservation now is
      at #{@reservation.restaurant.name}
      on #{@reservation.date}
      at #{@reservation.time}
      for #{@reservation.number_of_people} people!"
      view_all_reservations
    end

    ########################REVIEW METHODS############################
    def write_review
      puts `clear`
      if !@restaurant.users.include?(@user)
        @prompt.select("You haven't visited this restaurant, would you like to make a reservation?") do |menu|
          menu.choice "yes", -> { make_reservation }
          menu.choice "no", -> { choices }
        end
      else
        puts "What would you rate this restaurant from 1-5?"
        rating = gets.chomp

        puts "What comments do you have about this restaurant?"
        content = gets.chomp
        new_review = Review.create(rating: rating, content: content, user_id: @user.id, restaurant_id: @restaurant.id)
        choices
      end
    end


    def reviews
      puts `clear`
      if @user.reviews.length == 0
        puts "You have no reviews at this time"

        select_restaurant
      end

      @prompt.select("Choose a review to edit or delete") do |menu|
        Review.all.map do |review|
          if review.user_id == @user.id
            menu.choice "Review: #{review.content}\nRestaurant: #{review.restaurant}\nrating: #{review.rating}", -> { edit_or_delete_review(review) }
            puts "\n"
          end
        end
        menu.choice "back", -> { choices }
      end
    end


    def edit_or_delete_review(review)
      puts `clear`
      @review = review
      @prompt.select("Would you like to edit or delete this review?") do |menu|
        menu.choice "Edit the review", -> { edit_review }
        menu.choice "Delete the review", -> { delete_review }
        menu.choice "back", -> { choices }
      end
    end

    def edit_review
      puts `clear`
      puts "What would you rate this restaurant from 1-5?"
      rating = gets.chomp
      puts "What comments do you have about this restaurant?"
      content = gets.chomp

      restaurant = @review.restaurant
      @restaurant = Restaurant.find_by(name: restaurant)
      #binding.pry
      @review.update(rating: rating, content: content, user_id: @user.id, restaurant_id: @restaurant.id)
      choices
    end

    ############### Changes: added yes/no choice
    def delete_review
      puts `clear`
      @prompt.select("are you sure?") do |menu|
        menu.choice "yes", -> { @review.destroy }
        menu.choice "no", -> { reviews }
      end
      reviews
    end

    ########################PROMPT METHODS #########################################################
    def greeting_prompt

      # puts @pastel.yellow(@font.write("WELCOME TO MAKE RES"))
      # puts @font.write("your best way")
      # puts @font.write("to make reservations")

      @prompt.select("Select an option") do |menu|
        menu.choice 'returning user', -> { returning_user }
        menu.choice 'new user', -> { new_user }
        menu.choice 'quit app'
        menu.choice 'just a quick search', -> { yelp_results }
      end
    end

    def choices
      puts `clear`
      @prompt.select("what do you want to do today?") do |menu|
        menu.choice 'Choose a restaurant to make a reservation or leave a review', -> { select_restaurant }
        menu.choice 'View/edit your reservations', -> { view_all_reservations }
        ################## Changes: "see or edit reviews" for clarity
        menu.choice 'See or edit your reviews', -> { reviews }
        menu.choice 'View your favorite restaurants', -> { view_favorite_restaurants }
        menu.choice 'exit'
      end
    end

    def header_message
      puts @pastel.yellow(@font.write("WELCOME TO MAKE RES"))
      puts @font.write("your best way")
      puts @font.write("to make reservations")
    end


    def yelp_results
      final_hash = {}

      puts "what are you looking for?"
      term = gets.chomp
      puts "where are you located?"
      location = gets.chomp

      Yelp.search(term, location).each do |result_hash|
          name = result_hash["name"]
          number = result_hash["display_phone"]
          price = result_hash["price"]
          final_hash[name] = []
          final_hash[name] << number
          final_hash[name] << price
          #binding.pry
      end


      puts "these are some #{term} restaurants we found in #{location}"
      final_hash.each_with_index do |(restaurant, restaurant_data), i|
        puts "#{i+1}. #{restaurant} - #{restaurant_data[0]} - #{restaurant_data[1]}."
      end

    end


    def run
      header_message
      greeting_prompt
    end


end
