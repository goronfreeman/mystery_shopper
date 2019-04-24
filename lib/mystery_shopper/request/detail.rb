require 'mystery_shopper/request/base'

module MysteryShopper
  module Request
    class Detail < Base
      def initialize(**options)
        @application_id = MysteryShopper.configuration.application_id
        @api_key        = MysteryShopper.configuration.api_key
        @options        = options
      end

      private

      attr_reader :application_id, :api_key, :options

      def uri
        URI("https://#{application_id}-dsn.algolia.net/1/indexes/*/queries")
      end

      def body
        {
          'requests' => [
            {
              'indexName' => sort_direction,
              'params' => "query=&#{request_params}"
            }
          ]
        }
      end

      def request_params
        { hitsPerPage: defaults[:limit],
          page: defaults[:page],
          facets: facets,
          facetFilters: facet_filters }.map do |key, value|
            "#{key}=#{value}"
          end.join('&')
      end

      def facets
        %w[generalFilters
           platform
           availability]
      end

      def facet_filters
        [general_filters,
         platform,
         availability].compact
      end

      def general_filters
        return unless defaults[:sale]

        ['generalFilters:Deals']
      end

      # TODO: Support 3DS, Wii U, iOS, Android platforms
      def platform
        ['platform:Nintendo Switch']
      end

      def availability
        [
          defaults[:availability].map do |avail|
            "availability:#{mappings.dig(:availability, avail)}"
          end.join(', ')
        ]
      end

      def sort_direction
        return ['noa_aem_game_en_us'] if defaults[:sort] == 'featured'

        ['noa_aem_game_en_us_',
         defaults[:sort],
         defaults[:direction]].join('_')
      end

      def defaults
        { limit: 50,
          page: 0,
          availability: 'now',
          sort: 'title',
          direction: 'asc',
          system: 'switch' }.merge(options)
      end

      def mappings
        { availability: {
          'now' => 'Available now',
          'prepurchase' => 'Pre-purchase',
          'soon' => 'Coming soon'
        } }
      end
    end
  end
end
