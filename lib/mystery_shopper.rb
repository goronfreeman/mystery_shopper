require 'mystery_shopper/version'
require 'mystery_shopper/configuration'
require 'mystery_shopper/response'
require 'mystery_shopper/request/detail'
require 'mystery_shopper/request/price'

module MysteryShopper
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
