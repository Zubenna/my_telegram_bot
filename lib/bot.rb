require 'rubygems'
require 'telegram/bot'
require_relative 'weather_info.rb'

class Bot
  def initialize
    token = '1307559213:AAG1e-4Ep8NBCA6__SNQvBdLIym9aPMkKCk'
  Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    stop_bot = false
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, welcome to weather forcaste chat bot created by Nnamdi Emelu, this bot will give you current weather information about your selected city.", date: message.date)
      bot.api.send_message(chat_id: message.chat.id, text: 'Use /start to start the bot')
      bot.api.send_message(chat_id: message.chat.id, text: 'Use /stop to stop the bot')
      bot.api.send_message(chat_id: message.chat.id, text: 'Use /disp_current to display current weather')
      bot.api.send_message(chat_id: message.chat.id, text: 'Use /list_city to list sample cities')
      bot.api.send_message(chat_id: message.chat.id, text: 'Use /enter_city to type in your city following the format, [City, Country code]. see list_city for example' )
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}", date: message.date)
    when '/list_city'
      values = WeatherForcast.new
      list = values.city_list
      bot.api.send_message(chat_id: message.chat.id, text: "#{list}", date: message.date)
    when '/disp_current'
      values = WeatherForcast.new
      response = values.request_weather_data
      bot.api.send_message(chat_id: message.chat.id, text: "Country code: #{response['sys']['country']}", date: message.date)
      bot.api.send_message(chat_id: message.chat.id, text: "City: #{response['name']}", date: message.date)
      bot.api.send_message(chat_id: message.chat.id, text: "Tempreture: #{'%.2f' % (response['main']['temp'] - 273.15).to_s} Degree Celsius", date: message.date)
      bot.api.send_message(chat_id: message.chat.id, text: "Pressure: #{response['main']['pressure']} hPa", date: message.date)
      bot.api.send_message(chat_id: message.chat.id, text: "Humidity: #{response['main']['humidity']}%", date: message.date)
      bot.api.send_message(chat_id: message.chat.id, text: "Visibility: #{response['visibility']}", date: message.date)
      bot.api.send_message(chat_id: message.chat.id, text: "Wind Speed: #{response['wind']['speed']}m/s", date: message.date)
      bot.api.send_message(chat_id: message.chat.id, text: "Longitude: #{response['coord']['lon']}", date: message.date)
      bot.api.send_message(chat_id: message.chat.id, text: "Latitude: #{response['coord']['lat']}", date: message.date)
    # when '/enter_city'
    #   input = message.text
    else
      bot.api.send_message(chat_id: message.chat.id, text: "Your selection is wrong:")
    end
  end
 end
 end
end