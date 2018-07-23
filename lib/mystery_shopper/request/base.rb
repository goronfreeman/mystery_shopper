require 'json'
require 'net/http'
require 'uri'

module MysteryShopper
  module Request
    class Base
      def get
        JSON.parse(Net::HTTP.get(construct_uri))
      end

      private

      def construct_uri
        URI(uri).tap do |uri|
          uri.query = URI.encode_www_form(params)
        end
      end
    end
  end
end
