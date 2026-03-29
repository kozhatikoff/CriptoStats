require_relative "lib/crypto_tracker_pro/version"

Gem::Specification.new do |spec|
  spec.name = "crypto_tracker_pro"
  spec.version = CryptoTrackerPro::VERSION
  spec.authors = ["kozhatikoff"]
  spec.email = ["kozhatikoff@example.com"]

  spec.summary = "Crypto tracker with GUI and console modes"
  spec.description = "Tracks crypto prices, builds reports, and simulates portfolio performance."
  spec.homepage = "https://github.com/kozhatikoff/CriptoStats"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.files = Dir[
    "lib/**/*.rb",
    "bin/*",
    "README.md",
    "LICENSE",
    "Gemfile"
  ]
  spec.bindir = "bin"
  spec.executables = ["crypto-tracker-pro", "crypto-tracker-console"]
  spec.require_paths = ["lib"]

  spec.metadata["source_code_uri"] = spec.homepage
end
