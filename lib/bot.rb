# require 'rubygems'
require 'telegram/bot'
require_relative 'weather_info'

class Bot
  def initialize
    token = '1307559213:AAG1e-4Ep8NBCA6__SNQvBdLIym9aPMkKCk'

  Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}, welcome to weather forcaste chat bot created by Nnamdi Emelu, the bot is to keep updated about weather forcaste of ceratin cities. Use  /start to start the bot,  /end to end the bot, /forcast to get a weather focaste of diffrent cities anytime you want it.")
    when '/end'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}, date: message.date")
    when '/forcast'
        values = WeatherForcast.new
        # value = 
        # bot.api.send_message(chat_id: message.chat.id, text: "#{value['text']}", date: message.date) 
    else
      # bot.api.send_message(chat_id: message.chat.id, text: "Your selection is wrong:")
    end
  end
 end
 end
end