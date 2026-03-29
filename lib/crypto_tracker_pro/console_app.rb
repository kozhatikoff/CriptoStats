require_relative "api_client"
require_relative "analyzer"
require_relative "portfolio_calculator"

module CryptoTrackerPro
  class ConsoleApp
    def initialize
      @api = ApiClient.new
    end

    def run
      system("clear") || system("cls")
      puts "═" * 60
      puts "          CRYPTO TRACKER PRO"
      puts "═" * 60

      coins = @api.get_coins_list
      puts "\nДоступные монеты:"
      coins.each_with_index { |coin, i| puts "  #{i + 1}. #{coin}" }

      print "\nВыберите монету (1-#{coins.length}): "
      choice = gets&.chomp.to_i - 1
      selected_coin = coins[choice] if choice >= 0 && choice < coins.length

      unless selected_coin
        puts "Неверный выбор"
        return
      end

      print "\nВалюта (USD/EUR/RUB): "
      currency = gets&.chomp&.upcase || "USD"

      puts "\nЗагрузка данных..."

      raw_prices = @api.fetch_data(selected_coin)
      prices = @api.convert_prices(raw_prices, currency)

      analyzer = Analyzer.new
      puts "\n" + "═" * 60
      puts analyzer.build_report_text(prices, currency)
      puts "═" * 60

      portfolio = PortfolioCalculator.new
      puts "\n" + portfolio.calculate_investment(prices, 100)
    rescue StandardError => e
      puts "\nОшибка: #{e.message}"
    end
  end
end
