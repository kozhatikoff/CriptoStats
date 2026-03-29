require 'net/http'
require 'json'

class ApiClient
  COINS = {
    'Биткоин (BTC)' => 'bitcoin',
    'Эфириум (ETH)' => 'ethereum',
    'ТОН (TON)' => 'the-open-network'
  }

  RATES = {
    'USD' => 1.0,
    'EUR' => 0.92,
    'RUB' => 92.5
  }

  def fetch_data(coin_name)
    coin_id = COINS[coin_name]
    url = URI("https://api.coingecko.com/api/v3/coins/#{coin_id}/market_chart?vs_currency=usd&days=365")
    
    response = Net::HTTP.get(url)
    data = JSON.parse(response)
    
    data['prices'].map { |item| item[1] }
  end

  def get_coins_list
    COINS.keys
  end

  def convert_prices(prices, currency)
    rate = RATES[currency]
    prices.map { |price| price * rate }
  end
end