# require 'telegram/bot'
require 'net/http'
require 'json'
require_relative 'bot'
class WeatherForcast
  @values = nil
  def initialize
    # @values = @make_the_request
  end
  def make_the_request
    url = ''

    escaped_address = URI.escape(url)
    uri = URI.parse(escaped_address)
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)
    response
  end
end
