require_relative '../config/environment'


class CommandLineInterface

  def initialize
    @prompt = TTY::Prompt.new
    @user = nil
  end


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

    def select_restaurant
      @prompt.select("pick a restaurant") do |menu|
        Restaurant.all.map do |restaurant|
          menu.choice restaurant.name, -> { restaurant.make_reservation }
        end
        menu.choice "back", -> { choices }
        menu.choice "exit"
      end
    end






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
        menu.choice 'view your reservations', -> { @user.reservations }
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
#
# welcome user to service
# ask to create account or enter name
# give options of
#
#   -make reservation
#   -view reservations
#     -edit reservation
#     -delete reservation
#   -view reviews
#   -add review
#   -view favorite restaurants




  cli = CommandLineInterface.new
  cli.run




# https://maps.googleapis.com/maps/api/place/findplacefromtext/output?parameters

# API_KEY = "AIzaSyDlFzVIkqtTEuuhFi5ACR6OVx-YbtkVWOc"
# response = RestClient.get("https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=Restaurant%20%Dumbo&inputtype=textquery,name,rating&key=AIzaSyDlFzVIkqtTEuuhFi5ACR6OVx-YbtkVWOc")
# puts JSON.parse(response.body)
