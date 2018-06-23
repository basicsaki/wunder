require "pry"

files = ["./wunder/version.rb", "./wunder/parser.rb",
         "./wunder/promotion.rb", "./wunder/checkout.rb", "./wunder/print.rb"]
rule_files = Dir[File.join(__dir__, "wunder", "promotional", "rule", "*.rb")]

(files | rule_files).each do |file|
  require_relative file
end

module Wunder
  Money.default_currency = Money::Currency.new("EUR")
  Money.use_i18n = false
end
