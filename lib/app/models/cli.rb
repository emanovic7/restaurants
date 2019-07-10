

class CommandLineInterface

  def initialize
    @prompt = TTY::Prompt.new
    @user = nil
    @reservation = nil
    @restaurant = nil
  end





    ###############################USER METHODS#######################################
    def new_user
      puts "Please enter your name: "
      user_input = gets.chomp
      new_user = User.create(name: user_input)
      puts "Welcome to Make Res, #{new_user.name}"
      @user = new_user
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
        end
        @user = ret_user
    end

    def view_all_reservations
      @prompt.select("Here are your reservations") do |menu|
        Reservation.all.map do |reservation|
          if reservation.user_id == @user.id
            @reservation = reservation
            menu.choice "#{@reservation.restaurant.name} - #{@reservation.time}", -> {view_reservation}
          end
        end
        menu.choice "back", -> { choices }
      end

    #  puts "You have a reservation at #{reservation.restaurant.name} on #{reservation.date} at #{reservation.time} for #{reservation.number_of_people}."
    #  @prompt.select("Do you want to :") do |menu|
    #    menu.choice "edit", -> {update_reservation}
    #    menu.choice "delete", -> {"delete reservation"}
    #  end
   end








    ##########################RESTAURANT METHODS#############################
    #SELECT
    def select_restaurant
      @prompt.select("pick a restaurant") do |menu|
        Restaurant.all.map do |restaurant|
          @restaurant = restaurant
          menu.choice restaurant.name, -> { make_reservation }
        end
        menu.choice "back", -> { choices }
        menu.choice "exit"
      end
    end

    #MAKE RESERVATION
    def make_reservation
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

      reservation = Reservation.create(user_id: new_user.id, restaurant_id: @restaurant.id, time: res_time, date: res_date, number_of_people: res_num )

      puts "You have just made a reservation at #{reservation.restaurant.name}"
      puts "on #{reservation.date}"
      puts "at #{reservation.time}"
      puts "for #{reservation.number_of_people} person(s)"

      choices
    end

    #VIEW
    def view_reservation
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
      @prompt.select("are you sure?") do |menu|
        menu.choice "yes", -> { @reservation.destroy }
        menu.choice "no", -> { view_reservation }
      end
      view_all_reservations
    end


    #UPDATE
    def update_reservation
      @prompt.select("What would you like to change?") do |menu|
        menu.choice 'I want to change the date', -> { change_date }
        menu.choice 'I want to change the time', -> { change_time }
        menu.choice 'I want to change the number of people in my party', -> { change_num_people }
      end
    end

        def change_date
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




    ########################PROMPT METHODS #########################################################
    def greeting_prompt
      puts "Welcome To MaKe Res"
      puts "your best way to make reservations"

      @prompt.select("Select an option") do |menu|
        menu.choice 'returning user', -> { returning_user }
        menu.choice 'new user', -> { new_user }
      end
    end

    def choices
      @prompt.select("what do you want to do today?") do |menu|
        menu.choice 'make reservation', -> { select_restaurant }
        menu.choice 'view/edit your reservations', -> { view_all_reservations }
        menu.choice 'view your reviews', -> { @user.reviews }
        menu.choice 'review a restaurant'
        menu.choice 'view your favorite restaurants'
      end
    end


    def run
      greeting_prompt
      choices
    end


end
