require_relative '../lib/bot.rb'
require_relative '../lib/weather_info.rb'
require_relative '../lib/keys.rb'

# This test starts the bot, but result can be confirmed after pressing ctrl and C
# Add comment to run other test
describe Bot do
=begin
  let(:bot) { Bot.new(telegram_token, weather_key) }
  describe '#initialize' do
    it 'Starts the Bot without error' do
      expect(bot.class).to eql Bot
    end
  end
=end
describe '#some_daily_data' do
  test_value = Bot.new(telegram_token, weather_key)
  attr_reader :telegram_token, :openweather_key
  def initialize(token_telegram, key_openweather)
    @telegram_token = token_telegram
    @openweather_key = key_openweather
      # bot.listen do |message|
        test_value = Bot.new(telegram_token, weather_key)
        it 'Returns nil if method works' do
          expect(test_value.get_city(bot)).to eql(nil)
        end
      end
    end
end

