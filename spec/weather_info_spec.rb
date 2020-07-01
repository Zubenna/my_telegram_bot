require_relative '../lib/weather_info.rb'

describe '#WeatherForcast' do
  describe '#city_list' do
    test_weather = WeatherForcast.new
    test_array = ['Lagos, NG', 'Port Harcourt, NG', 'Abuja, NG', 'Madrid, ES', 'London, UK']
    it 'Returned array should be equal to test_array' do
      expect(test_weather.city_list).to eq(test_array)
    end
  end

  describe '#request_weather_data' do
    test_weather = WeatherForcast.new
    temp_request = 'current'
    test_city = 'Lagos, NG'
    weather_data = test_weather.request_weather_data(test_city, temp_request)
    it 'Ensures that call to OpenWeather api returns expected country code' do
      expect(weather_data['sys']['country']).to eq('NG')
    end
    it 'Ensures that call to OpenWeather api returns expected city name' do
      expect(weather_data['name']).to eq('Lagos')
    end
    it 'Ensures that call to OpenWeather api returns expected Latitude' do
      expect(weather_data['coord']['lon']).to eq(3.75)
    end
    it 'Ensures that call to OpenWeather api returns expected Longitude' do
      expect(weather_data['coord']['lat']).to eq(6.58)
    end
  end
end
