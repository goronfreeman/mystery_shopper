require 'net/http'
require 'uri'

module MysteryShopper
  class Request
    def initialize(options = {})
      @options = options
    end

    def get
      Net::HTTP.get(uri)
    end

    private

    attr_reader :options

    def uri
      URI('https://www.nintendo.com').tap do |uri|
        uri.path  = '/json/content/get/filter/game'
        uri.query = URI.encode_www_form(params)
      end
    end

    def params
      { limit: 50,
        offset: 0,
        sale: true,
        sort: 'featured',
        direction: 'asc',
        system: 'switch' }.merge(options)
    end
  end
end
