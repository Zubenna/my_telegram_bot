# Weather Forcaster Telegram bot

The aim of this project is to make a telegram bot that gives information about current weather and daily weather forecast for a selected city. Project was built using ruby language.

My major driving force to implement this project is to simplify the process of getting accurate current and daily weather report of major cities around the world just by entering the city in the telegram app installed in your device.
This project calls OpenWeather API to retrieve information for current weather or daily weather forcast for the chosen city. You need to provide the name of the city and your country code when prompted by the telegram app. Infomation for all the major cities in OpenWeather database can be retreived. This project helps you to know your current weather report easily from the telegram app installed in your device any time of the day.

## Main Features Of This Bot

- It can display array of sample cities you can follow when entering your own city.
- It can display current weather information of selected city specifying details such as temperature, pressure, latitude, longitude, wind speed, humudity, visibility, your city and country code.
- It can display daily weather forcast with same details specified above including cloud state.
- Bot works in telegram app installed in devices like computer, mobile phone, and tablets.

## Prerequisite for Using this Bot and Getting Ready
- Ensure telegram app is installed in your device and you have a telegram account.
- Ensure Ruby is installed in your computer.
- Create a bot token by following the guide [here](https://core.telegram.org/bots#6-botfather). I left my token for the purpose of learning and testing.
- Fork this project and clone into your local machine/computer.
- From your terminal change directory (cd) into my_telegram_bot folder.
- Install ruby gems by running "bundle install" on your terminal.
- Run 'ruby bin/main.rb' on your terminal to start the bot.
- Enter cntrl and C to stop bot.
- Open Telegram and start talking with @weather_forcaster.

## How to Use
- Type 'ruby bin/main.rb' in your terminal to start the telegram bot.![Start bot](image/bot_pic_one.png)
- Launch your telegram app, type 'weather_forcaster' in your search bar and click on it to initiate communication with it.![Launch Telegram](image/bot_pic_two.png)
- Type '/start' in your telegram and press enter to display user guide ![User guide](image/bot_ptc_three.png)
- Type '/forcast' in telegram and press enter, enter city e.g Tokyo, JP to display the days' weather forcast for the city. ![Get daily forcast](image/bot_pic_four.png)
- Type '/list_city' in telegram and press enter, to display sample list of cities. ![Sample Cities](image/bot_pic_five.png)
- Type '/current' in telegram and press enter, enter city to dispaly current weather information for the specified city. ![Get Current weather data](image/bot_pic_six.png)
- Type cntrl and C in your terminal to end the bot first. Then type '/stop' in your telegram app and press enter to end the operation. ![Stop Bot](image/bot_pic_seven.png)

## Built With

- Ruby version 2.6.5.
- Telegram/bot
- Rspec
- [OpenWeather API](https://openweathermap.org/api)

## Authors

👤 **Nnamdi Emelu**

- Github: [@githubhandle](https://github.com/zubenna)
- Twitter: [@twitterhandle](https://twitter.com/zubenna)
- Linkedin: [linkedin](https://linkedin.com/in/nnamdi-emelu-08b14340/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/Zubenna/my_telegram_bot/issues)

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Project inspired by Microverse Program

