require_relative '../config/environment'
require 'pry'


class CommandLineInterface

  def initialize
    @prompt = TTY::Prompt.new
    @user
  end

  def self.prompt
    @prompt
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
          puts "User name not found, please try again or create an account"
          greeting_prompt
        else
          puts "Welcome back, #{ret_user.name}!"
        end
      @user = ret_user
    end

    def select_restaurant
      @prompt.select("Pick a restaurant") do |menu|
        Restaurant.all.map do |restaurant|
          menu.choice restaurant.name, -> { restaurant.make_reservation }
        end
        menu.choice "exit"
      end
    end

    def view_or_edit_reservations
      @prompt.select("Choose a reservation to edit.\n") do |menu|
        Reservation.all.each do |reservation|
          if reservation.user_id == @user.id
            menu.choice "You have a reservation at #{reservation.restaurant.name} on #{reservation.date} at #{reservation.time}.", -> { reservation.update_reservation }
          end
        end
      end
    end






    def greeting_prompt
      puts "Welcome To MaKe Res"
      puts "Your best way to make reservations"

      @prompt.select("Select an option:\n") do |menu|
        menu.choice 'I am a returning user', -> { returning_user }
        menu.choice 'I am a new user', -> { new_user }
      end
    end

    def choices
      @prompt.select("What do you want to do today?\n") do |menu|
        menu.choice 'Make a reservation', -> { select_restaurant }
        menu.choice 'View/edit my reservations', -> { view_or_edit_reservations }
        menu.choice 'View your reviews'
        menu.choice 'Review a restaurant'
        menu.choice 'View your favorite restaurants'
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
