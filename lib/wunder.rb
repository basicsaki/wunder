require "pry"
require "bigdecimal"

files = ["./wunder/version.rb","./wunder/modules.rb","./wunder/parser.rb",
		"./wunder/promotion.rb","./wunder/checkout.rb"]
rule_files = Dir[File.join(__dir__, 'wunder', 'promotional','rule','*.rb')]

(files | rule_files).each do |file|
	require file
end

module Wunder
end
