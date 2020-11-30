require 'telegram/bot'
require 'json'
require 'uri'
require 'net/http'
require_relative 'bot'
class WeatherForcast
  attr_reader :key_value
  def initialize(key_openweather)
    @key_value = key_openweather
  end

  def request_weather_data(city, data, lat = nil, lon = nil)
    if data.eql?('current')
      url = "http://api.openweathermap.org/data/2.5/weather?q=#{city}&APPID=#{key_value}"
    elsif data.eql?('daily')
      url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lon}&
      exclude=current,minutely,hourly&appid=#{key_value}"
    end
    get_weather_data(url)
  end

  def city_list
    city = ['Lagos, NG', 'Port Harcourt, NG', 'Abuja, NG', 'Madrid, ES', 'London, UK']
    city
  end

  private
  def get_weather_data(url)
    uri = URI(url)
    response = Net::HTTP.get(uri)
    response = JSON.parse(response)
    response
  end
end
