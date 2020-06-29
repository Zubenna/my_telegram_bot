#!/usr/bin/ruby
require_relative '../lib/bot.rb'
require_relative '../lib/weather_info.rb'
puts 'Hello! , Welcome to weather forcast telegram bot'
puts '----------------------------------------------'
puts 'This is a bot to help you know the weather forcast and condition for different cities'
puts 'whenever you want.'
sleep(0.8)
puts '----------------------------------------------'
puts '...loading'
puts 'bot is now online... use ctrl-c to stop the bot'
Bot.new