require "net/http"
require "json"

module CryptoTrackerPro
  class ApiClient
    COINS = {
      "Биткоин (BTC)" => "bitcoin",
      "Эфириум (ETH)" => "ethereum",
      "ТОН (TON)" => "the-open-network"
    }.freeze

    RATES = {
      "USD" => 1.0,
      "EUR" => 0.92,
      "RUB" => 92.5
    }.freeze

    def fetch_data(coin_name)
      normalized_coin = normalize_coin_name(coin_name)
      coin_id = COINS[normalized_coin]
      raise ArgumentError, "Неизвестная монета: #{coin_name}" if coin_id.nil?

      url = URI("https://api.coingecko.com/api/v3/coins/#{coin_id}/market_chart?vs_currency=usd&days=365")
      response = Net::HTTP.get_response(url)
      raise StandardError, "HTTP #{response.code} from CoinGecko" unless response.is_a?(Net::HTTPSuccess)

      data = JSON.parse(response.body)
      prices = data["prices"]
      raise StandardError, "Некорректный ответ API" unless prices.is_a?(Array)

      prices.map { |item| item[1] }
    end

    def get_coins_list
      COINS.keys
    end

    def convert_prices(prices, currency)
      rate = RATES[currency]
      raise ArgumentError, "Неподдерживаемая валюта: #{currency}" if rate.nil?

      prices.map { |price| price * rate }
    end

    private

    def normalize_coin_name(coin_name)
      value = coin_name.to_s.strip
      return value if value.empty?

      # Tk may return a string with non-UTF-8 encoding.
      value = value.dup.force_encoding("UTF-8")
      value.valid_encoding? ? value : value.encode("UTF-8", invalid: :replace, undef: :replace, replace: "")
    end
  end
end
