require 'date'
require 'mystery_shopper/utils'
require 'mystery_shopper/price'
require 'mystery_shopper/request/price'

module MysteryShopper
  class Game
    include Utils

    def initialize(data)
      @data = data
    end

    def categories
      @categories ||= Array(data.dig('categories', 'category'))
    end

    def url
      @url ||= "https://www.nintendo.com/games/detail/#{slug}"
    end

    def buy_it_now?
      @buy_it_now ||= to_bool(data.fetch('buyitnow'))
    end

    def release_date
      @release_date ||= Date.parse(data.fetch('release_date'))
    end

    def digital_download?
      @digital_download ||= to_bool(data.fetch('digitaldownload'))
    end

    def free_to_start?
      @free_to_start ||= to_bool(data.fetch('free_to_start'))
    end

    def title
      @title ||= data.fetch('title')
    end

    def slug
      @slug ||= data.fetch('slug')
    end

    def system
      @system ||= data.fetch('system')
    end

    def id
      @id ||= data.fetch('id')
    end

    def number_of_players
      @number_of_players ||= data.fetch('number_of_players')
    end

    def nsuid
      @nsuid ||= data['nsuid']
    end

    def video_link
      @video_link ||= data['video_link']
    end

    def front_box_art
      @front_box_art ||= data.fetch('front_box_art')
    end

    def game_code
      @game_code ||= data.fetch('game_code')
    end

    def buy_online?
      @buy_online ||= to_bool(data.fetch('buyonline'))
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
  end
end
