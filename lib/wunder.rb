require_relative "./wunder/version.rb"

Dir[File.dirname(__FILE__) + "wunder/*.rb"].each do |file|
  require File.basename(file, File.extname(file))
end

module Wunder
  module Promotion
  	module Rule
  	end
  end
end
