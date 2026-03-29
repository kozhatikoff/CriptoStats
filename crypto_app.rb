require 'tk'
require 'tkextlib/tile'
require_relative 'api_client'
require_relative 'analyzer'
require_relative 'portfolio'
require_relative 'chart_drawer'

class CryptoApp
  def run
    api = ApiClient.new
    analyzer = Analyzer.new
    portfolio = PortfolioCalculator.new
    chart_drawer = ChartDrawer.new

    root = TkRoot.new do
      title "Crypto Tracker Pro"
      geometry "450x800"
      background '#F0F0F0'
    end

    selected_coin = TkVariable.new(api.get_coins_list.first)
    selected_currency = TkVariable.new('USD')

    theme_btn = TkButton.new(root) do
      text "Сменить тему 🌙"
      pack(anchor: 'e', padx: 10, pady: 5)
    end

    TkLabel.new(root, text: 'Монета:').pack
    Tk::Tile::Combobox.new(root) do
      values api.get_coins_list
      textvariable selected_coin
      state 'readonly'
      pack
    end

    TkLabel.new(root, text: 'Валюта:').pack
    curr_frame = TkFrame.new(root).pack
    
    ['USD', 'EUR', 'RUB'].each do |curr|
      TkRadiobutton.new(curr_frame) do
        text curr
        value curr
        variable selected_currency
        pack(side: 'left', padx: 5)
      end
    end

    analyze_btn = TkButton.new(root, text: "Анализировать").pack(pady: 10)

    canvas = chart_drawer.build_canvas(root)

    output_text = TkText.new(root, width: 45, height: 14, font: 'Courier 10', background: 'white').pack(pady: 5)

    TkLabel.new(root, text: 'Машина времени (вложили 100$ год назад):').pack(pady: 5)
    portfolio_text = TkText.new(root, width: 45, height: 3, font: 'Courier 10', background: 'white').pack

  
    theme_btn.command = proc do
      is_light = root.background == '#F0F0F0'
      
      bg = is_light ? '#2B2B2B' : '#F0F0F0'
      fg = is_light ? '#FFFFFF' : '#000000'
      text_bg = is_light ? '#3C3C3C' : '#FFFFFF'

      root.background = bg
      output_text.background = text_bg
      output_text.foreground = fg
      portfolio_text.background = text_bg
      portfolio_text.foreground = fg
      canvas.background = text_bg
    end

    analyze_btn.command = proc do
      output_text.value = "Загрузка..."
      
      begin
        raw_prices = api.fetch_data(selected_coin.value)
        prices = api.convert_prices(raw_prices, selected_currency.value)

        output_text.value = analyzer.build_report_text(prices, selected_currency.value)
        portfolio_text.value = portfolio.calculate_investment(prices, 100)
        chart_drawer.draw(canvas, prices)
      rescue => e
        output_text.value = "Ошибка сети: #{e.message}"
      end
    end

    Tk.mainloop
  end
end