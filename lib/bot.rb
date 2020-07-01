require 'rubygems'
require 'telegram/bot'
require_relative 'weather_info.rb'

class Bot
  # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Layout/LineLength
  def initialize
    token = '1307559213:AAG1e-4Ep8NBCA6__SNQvBdLIym9aPMkKCk'
    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, welcome to weather information bot created by Nnamdi Emelu, this bot will give you current weather information about your selected city. It will also display daily weather forcast of your selected city", date: message.date)
          bot.api.send_message(chat_id: message.chat.id, text: 'Use /start to start the bot')
          bot.api.send_message(chat_id: message.chat.id, text: 'Use /stop to stop the bot')
          bot.api.send_message(chat_id: message.chat.id, text: 'Use /forcast to display next 3hours weather forcast in your city')
          bot.api.send_message(chat_id: message.chat.id, text: 'Use /list_city to list sample cities')
          bot.api.send_message(chat_id: message.chat.id, text: 'Use /current to type in your city following the format, [City, Country code]. see list_city for example')
          bot.api.send_message(chat_id: message.chat.id, text: 'Make one selection, stop bot after display', date: message.date)
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}", date: message.date)
        when '/list_city'
          values = WeatherForcast.new
          list = values.city_list
          bot.api.send_message(chat_id: message.chat.id, text: list.to_s, date: message.date)
        when '/current'
          bot.api.send_message(chat_id: message.chat.id, text: 'Enter your city and country code to get current weather information')
          bot.api.send_message(chat_id: message.chat.id, text: 'Example Lagos, NG')
          get_city(bot)
        when '/forcast'
          bot.api.send_message(chat_id: message.chat.id, text: 'Enter your city and country code to get daily weather information')
          bot.api.send_message(chat_id: message.chat.id, text: 'Example Lagos, NG')
          forcast_weather(bot)
        else
          bot.api.send_message(chat_id: message.chat.id, text: 'Your selection is wrong:')
        end
      end
    end
  end
  # rubocop:enable Metrics/AbcSize,Metrics/MethodLength,Layout/LineLength

  def get_city(bot)
    bot.listen do |message|
      case message
      when Telegram::Bot::Types::Message
        request_type = 'current'
        input_city = message.text
        values = WeatherForcast.new
        response = values.request_weather_data(input_city, request_type)
        display_current(message, response, bot)
      end
    end
  end

  def forcast_weather(bot)
    bot.listen do |message|
      case message
      when Telegram::Bot::Types::Message
        request_type = 'daily'
        temp_request = 'current'
        input_city = message.text
        values = WeatherForcast.new
        response = values.request_weather_data(input_city, temp_request)
        lat = response['coord']['lat']
        lon = response['coord']['lon']
        response_two = values.request_weather_data(input_city, request_type, lat, lon)
        display_daily(message, response_two, bot)
      end
    end
  end

  # rubocop:disable Metrics/AbcSize,Layout/LineLength
  def display_current(message, response, bot)
    bot.api.send_message(chat_id: message.chat.id, text: 'Current weather information', date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Country code: #{response['sys']['country']}", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "City: #{response['name']}", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Tempreture: #{(response['main']['temp'] - 273.15).round(2)} Degree Celsius", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Pressure: #{response['main']['pressure']} hPa", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Humidity: #{response['main']['humidity']}%", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Visibility: #{response['visibility']}", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Wind Speed: #{response['wind']['speed']}m/s", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Longitude: #{response['coord']['lon']}", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Latitude: #{response['coord']['lat']}", date: message.date)
  end
  # rubocop:enable Metrics/AbcSize,Layout/LineLength

  # rubocop:disable Metrics/AbcSize,Layout/LineLength
  def display_daily(message, response, bot)
    bot.api.send_message(chat_id: message.chat.id, text: 'Weather forcast for today', date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Timezone: #{response['timezone']}", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Cloud: #{response['current']['clouds']}%", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Tempreture: #{(response['current']['temp'] - 273.15).round(2)} Degree Celsius", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Pressure: #{response['current']['pressure']} hPa", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Humidity: #{response['current']['humidity']}%", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Visibility: #{response['current']['visibility']}", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Wind Speed: #{response['current']['wind_speed']}m/s", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Longitude: #{response['lat']}", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Latitude: #{response['lon']}", date: message.date)
  end
  # rubocop:enable Metrics/AbcSize,Layout/LineLength
end