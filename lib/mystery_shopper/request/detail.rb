require 'mystery_shopper/request/base'

module MysteryShopper
  module Request
    class Detail < Base
      def initialize(**options)
        @options = options
      end

      private

      attr_reader :options

      def uri
        'https://www.nintendo.com/json/content/get/filter/game'
      end

      def params
        { limit: 50,
          offset: 0,
          sale: false,
          availability: 'now',
          sort: 'title',
          direction: 'asc',
          system: 'switch' }.merge(options)
      end
    end
  end
end
