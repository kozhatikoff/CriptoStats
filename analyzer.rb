class Analyzer
  def get_symbol(currency)
    currency == 'RUB' ? '₽' : (currency == 'EUR' ? '€' : '$')
  end

  def analyze_period(prices, days)
    period = prices.last(days)
    
    min = period.min.round(2)
    max = period.max.round(2)
    avg = (period.sum / period.length).round(2)
    
    start_price = period.first
    end_price = period.last
    percent = (((end_price - start_price) / start_price) * 100).round(2)

    trend = percent > 0 ? "Рост 📈 (+#{percent}%)" : "Падение 📉 (#{percent}%)"

    { min: min, max: max, avg: avg, trend: trend }
  end

  def build_report_text(prices, currency)
    symbol = get_symbol(currency)
    week = analyze_period(prices, 7)
    month = analyze_period(prices, 30)
    year = analyze_period(prices, 365)

    text = "Текущая цена: #{symbol}#{prices.last.round(2)}\n\n"
    
    text += "--- 7 ДНЕЙ ---\n"
    text += "Средняя: #{symbol}#{week[:avg]} | #{week[:trend]}\n"
    text += "Мин: #{symbol}#{week[:min]} | Макс: #{symbol}#{week[:max]}\n\n"

    text += "--- 30 ДНЕЙ ---\n"
    text += "Средняя: #{symbol}#{month[:avg]} | #{month[:trend]}\n"
    text += "Мин: #{symbol}#{month[:min]} | Макс: #{symbol}#{month[:max]}\n\n"

    text += "--- 1 ГОД ---\n"
    text += "Средняя: #{symbol}#{year[:avg]} | #{year[:trend]}\n"
    text += "Мин: #{symbol}#{year[:min]} | Макс: #{symbol}#{year[:max]}\n"

    text
  end
end