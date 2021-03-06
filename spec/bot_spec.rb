require_relative '../lib/bot.rb'
require_relative '../lib/weather_info.rb'
require_relative '../lib/keys.rb'

# This test starts the bot, but result can be confirmed after pressing ctrl and C
# Add comment to run other test
describe Bot do
  let(:bot) { Bot.new(telegram_token, weather_key) }
  describe '#initialize' do
    it 'Starts the Bot without error' do
      expect(bot.class).to eql Bot
    end
  end
end
