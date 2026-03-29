module CryptoTrackerPro
  class PortfolioCalculator
    def calculate_investment(prices, amount_invested)
      return "Нет данных за год" if prices.length < 365

      price_1_year_ago = prices.first
      current_price = prices.last

      coins_bought = amount_invested.to_f / price_1_year_ago
      current_value = coins_bought * current_price
      profit = current_value - amount_invested

      if profit.positive?
        "Вложив #{amount_invested}, сейчас вы бы имели #{current_value.round(2)}\nПрибыль: +#{profit.round(2)} 🤑"
      else
        "Вложив #{amount_invested}, сейчас вы бы имели #{current_value.round(2)}\nУбыток: #{profit.round(2)} 😭"
      end
    end
  end
end
