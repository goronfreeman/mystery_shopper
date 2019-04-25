require 'json'
require 'net/http'
require 'uri'

module MysteryShopper
  module Request
    class Base
      def get
        JSON.parse(Net::HTTP.get(construct_uri))
      end

      def post
        JSON.parse(Net::HTTP.new(construct_uri.host).request(construct_request).body)
      end

      private

      def construct_request
        Net::HTTP::Post.new(construct_uri).tap do |request|
          request.body = body.to_json
        end
      end

      def construct_uri
        URI.parse(uri).tap do |uri|
          uri.query = URI.encode_www_form(params)
        end
      end

      def params
        { 'x-algolia-application-id' => application_id,
          'x-algolia-api-key' => api_key }
      end
    end
  end
end
