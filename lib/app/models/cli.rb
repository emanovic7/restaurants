

class CommandLineInterface

  def initialize
    @prompt = TTY::Prompt.new
    @user = nil
    @reservation = nil
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
      end

    #  puts "You have a reservation at #{reservation.restaurant.name} on #{reservation.date} at #{reservation.time} for #{reservation.number_of_people}."
    #  @prompt.select("Do you want to :") do |menu|
    #    menu.choice "edit", -> {update_reservation}
    #    menu.choice "delete", -> {"delete reservation"}
    #  end
   end








    ##########################RESTAURANT METHODS#############################
    def select_restaurant
      @prompt.select("pick a restaurant") do |menu|
        Restaurant.all.map do |restaurant|
          menu.choice restaurant.name, -> { restaurant.make_reservation }
        end
        menu.choice "back", -> { choices }
        menu.choice "exit"
      end
    end

    def view_reservation
       puts "You have a reservation
       at #{@reservation.restaurant.name}
       on #{@reservation.date}
       at #{@reservation.time}
       for #{@reservation.number_of_people} people!"


        @prompt.select("You can :") do |menu|
          menu.choice "edit reservation", -> {update_reservation}
          menu.choice "delete reservation", -> {"delete reservation"}
        end

    end

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
        menu.choice 'view your reservations', -> { view_all_reservations }
        menu.choice 'edit a reservation', -> { @user.edit_reservation }
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
