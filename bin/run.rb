require_relative '../config/environment'
require 'pry'



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
