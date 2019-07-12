# Original Source: https://github.com/Yelp/yelp-fusion/tree/master/fusion/ruby
require "json"
require "http"

class YelpApiAdapter
  # #Returns a parsed json object of the request

    API_HOST = "https://api.yelp.com"
    SEARCH_PATH = "/v3/businesses/search"
    BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
    API_KEY = ENV["YELP_API_KEY"]

    DEFAULT_BUSINESS_ID = "yelp-san-francisco"
    DEFAULT_TERM = "dinner"
    DEFAULT_LOCATION = "New York, NY"
    SEARCH_LIMIT = 20

  def self.search(term, location="new york")
    url = "#{API_HOST}#{SEARCH_PATH}"
    params = {
      term: term,
      location: location,
      limit: SEARCH_LIMIT
    }
    response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
    response.parse["businesses"]
  end

  def self.business_reviews(business_id)
    url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}/reviews"
    response = HTTP.auth("Bearer #{API_KEY}").get(url)
    response.parse["reviews"]
  end

  def business(business_id)
    url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"
    response = HTTP.auth("Bearer #{API_KEY}").get(url)
    response.parse
  end

end

# puts YelpApiAdapter.search("restaurants", "brooklyn")
# all_restaurants = []
# # yelp = YelpApiAdapter.new
# YelpApiAdapter.search("restaurants", "brooklyn").each do |restaurant_hash|
#   restaurant_hash.each do |restaurant_key, restaurant_value|
#     if restaurant_key == "name"
#       all_restaurants << restaurant_value
#     end
#   end
# end
