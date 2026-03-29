# CryptoTrackerPro

RubyGem для анализа криптовалют:
- GUI-режим (Tk)
- консольный режим
- отчеты за 7/30/365 дней
- расчет "машины времени" для инвестиции на год

## Установка для разработки

```bash
bundle install
```

## Локальный запуск

### GUI

```bash
bundle exec ruby bin/crypto-tracker-pro
```

### Консоль

```bash
bundle exec ruby bin/crypto-tracker-console
```

## Сборка гема

```bash
gem build crypto_tracker_pro.gemspec
```

## Примечания

- Для GUI нужен `tk` (в некоторых окружениях его нужно установить отдельно на уровне системы).
- Курсы EUR/RUB внутри приложения заданы статически.
