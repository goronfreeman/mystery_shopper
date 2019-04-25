require 'mystery_shopper/request/base'

module MysteryShopper
  module Request
    class Price < Base
      def initialize(*ids, **options)
        @ids     = ids.join(',')
        @options = options
      end

      private

      attr_reader :ids, :options

      def uri
        'https://api.ec.nintendo.com/v1/price'
      end

      def params
        { country: 'US',
          lang: 'en',
          ids: ids }.merge(options)
      end
    end
  end
end
