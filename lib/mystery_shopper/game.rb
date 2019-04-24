require 'date'
require 'mystery_shopper/price'
require 'mystery_shopper/request/price'

module MysteryShopper
  class Game
    def initialize(data)
      @data = data
    end

    def categories
      @categories ||= data.fetch('categories')
    end

    def url
      @url ||= "#{base_url}#{data.fetch('url')}"
    end

    def release_date
      @release_date ||= Date.parse(data.fetch('releaseDateMask'))
    end

    def free_to_start?
      @free_to_start ||= data.fetch('freeToStart')
    end

    def title
      @title ||= data.fetch('title')
    end

    def slug
      @slug ||= data.fetch('slug')
    end

    def platform
      @platform ||= data.fetch('platform')
    end

    def id
      @id ||= data.fetch('id')
    end

    def number_of_players
      @number_of_players ||= data.fetch('players')
    end

    def nsuid
      @nsuid ||= data['nsuid']
    end

    def front_box_art
      @front_box_art ||= "#{base_url}#{data.fetch('boxArt')}"
    end

    def buy_online?
      @buy_online ||= data.fetch('buyonline')
    end

    def regular_price
      price_details.regular_price
    end

    def discount_price
      price_details.discount_price
    end

    def sales_status
      price_details.sales_status
    end

    def sale_start
      price_details.sale_start
    end

    def sale_end
      price_details.sale_end
    end

    private

    attr_reader :data

    def price_details
      @price_details ||= Price.new(
        Request::Price.new(nsuid).get.fetch('prices').first
      )
    end

    def base_url
      'https://www.nintendo.com'
    end
  end
end
