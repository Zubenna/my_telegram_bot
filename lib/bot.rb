require 'rubygems'
require 'telegram/bot'
require_relative 'weather_info.rb'
require_relative 'keys.rb'

class Bot
  # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Layout/LineLength
  attr_reader :telegram_token, :openweather_key
  def initialize(token_telegram, key_openweather)
    @telegram_token = token_telegram
    @openweather_key = key_openweather
    Telegram::Bot::Client.run(telegram_token) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, welcome to weather information bot created by Nnamdi Emelu, this bot will give you current weather information about your selected city. It will also display daily weather forcast of your selected city", date: message.date)
          bot.api.send_message(chat_id: message.chat.id, text: 'Use /start to start the bot')
          bot.api.send_message(chat_id: message.chat.id, text: 'Use /stop to stop the bot')
          bot.api.send_message(chat_id: message.chat.id, text: 'Use /forcast to display next 3hours weather forcast in your city')
          bot.api.send_message(chat_id: message.chat.id, text: 'Use /list_city to list sample cities and link to country codes')
          bot.api.send_message(chat_id: message.chat.id, text: 'Use /current to type in your city following the format, [City, Country code]. see list_city for example')
          bot.api.send_message(chat_id: message.chat.id, text: 'Make one selection, stop bot after display', date: message.date)
        when '/stop'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}", date: message.date)
        when '/list_city'
          values = WeatherForcast.new(openweather_key)
          list = values.city_list
          country_code_link = 'https://en.wikipedia.org/wiki/List_of_ISO_3166_country_codes'
          bot.api.send_message(chat_id: message.chat.id, text: list.to_s, date: message.date)
          bot.api.send_message(chat_id: message.chat.id, text: 'Click link below for list of two letter country code', date: message.date)
          bot.api.send_message(chat_id: message.chat.id, text: country_code_link.to_s, date: message.date)
        when '/current'
          bot.api.send_message(chat_id: message.chat.id, text: 'Enter your city and country code to get current weather information')
          bot.api.send_message(chat_id: message.chat.id, text: 'Example Lagos, NG')
          get_city(bot)
        when '/forcast'
          bot.api.send_message(chat_id: message.chat.id, text: 'Enter your city and country code to get daily weather information')
          bot.api.send_message(chat_id: message.chat.id, text: 'Example Madrid, ES')
          forcast_weather(bot)
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
        values = WeatherForcast.new(openweather_key)
        response = values.request_weather_data(input_city, request_type)
        some_current_data(message, response, bot)
        display_info(message, response, bot, request_type)
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
        values = WeatherForcast.new(openweather_key)
        response = values.request_weather_data(input_city, temp_request)
        lat = response['coord']['lat']
        lon = response['coord']['lon']
        response_two = values.request_weather_data(input_city, request_type, lat, lon)
        some_daily_data(message, response_two, bot)
        display_info(message, response_two, bot, request_type)
      end
    end
  end

  private

  # rubocop:disable Metrics/AbcSize,Layout/LineLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Style/ConditionalAssignment
  def display_info(message, response, bot, info_type)
    info_type.eql?('daily') ? temp = (response['current']['temp'] - 273.15).round(2) : temp = (response['main']['temp'] - 273.15).round(2)
    info_type.eql?('daily') ? presu = response['current']['pressure'] : presu = response['main']['pressure']
    info_type.eql?('daily') ? humid = response['current']['humidity'] : humid = response['main']['humidity']
    info_type.eql?('daily') ? visib = response['current']['visibility'] : visib = response['visibility']
    info_type.eql?('daily') ? wind = response['current']['wind_speed'] : wind = response['wind']['speed']
    info_type.eql?('daily') ? lat = response['lat'] : lat = response['coord']['lat']
    info_type.eql?('daily') ? lon = response['lon'] : lon = response['coord']['lon']
    bot.api.send_message(chat_id: message.chat.id, text: "Tempreture: #{temp} Degree Celsius", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Pressure: #{presu} hPa", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Humidity: #{humid}%", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Visibility: #{visib}", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Wind Speed: #{wind}m/s", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Latitude: #{lat}", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Longitude: #{lon}", date: message.date)
    Bot.new(telegram_token, weather_key)
  end
  # rubocop:enable Metrics/AbcSize,Layout/LineLength,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Style/ConditionalAssignment

  # rubocop:disable Metrics/AbcSize,Layout/LineLength
  def some_daily_data(message, response, bot)
    bot.api.send_message(chat_id: message.chat.id, text: 'Weather forcast for today', date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Timezone: #{response['timezone']}", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Cloud: #{response['current']['clouds']}%", date: message.date)
  end
  # rubocop:enable Metrics/AbcSize,Layout/LineLength

  # rubocop:disable Layout/LineLength
  def some_current_data(message, response, bot)
    bot.api.send_message(chat_id: message.chat.id, text: 'Current weather information', date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "Country code: #{response['sys']['country']}", date: message.date)
    bot.api.send_message(chat_id: message.chat.id, text: "City: #{response['name']}", date: message.date)
  end
  # rubocop:enable Layout/LineLength
end
