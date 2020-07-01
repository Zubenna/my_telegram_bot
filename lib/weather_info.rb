require 'telegram/bot'
require 'json'
require 'uri'
require 'net/http'
require_relative 'bot'
class WeatherForcast
    def request_weather_data(city, data, lat=nil, lon=nil)
      url = "http://api.openweathermap.org/data/2.5/weather?q=#{city}&APPID=4c726c2ad8e25995fa54253e43f9b966" if data.eql?('current')
      url = "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lon}&
      exclude=current,minutely,hourly&appid=4c726c2ad8e25995fa54253e43f9b966" if data.eql?('daily')
      uri = URI(url)
      response = Net::HTTP.get(uri)
      response = JSON.parse(response)
      response
    end
    def city_list
      city = ['Lagos, NG', 'Port Harcourt, NG', 'Abuja, NG', 'Madrid, ES', 'London, UK']
      city
    end
end
