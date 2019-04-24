require 'date'
require 'mystery_shopper/price'
require 'mystery_shopper/request/price'

module MysteryShopper
  class Game
    def initialize(data)
      @data = data
    end

    def url
      @url ||= "#{base_url}#{data.fetch('url')}"
    end

    def title
      @title ||= data.fetch('title')
    end

    def description
      @description ||= data.fetch('description')
    end

    def id
      @id ||= data.fetch('id')
    end

    def nsuid
      @nsuid ||= data['nsuid']
    end

    def slug
      @slug ||= data.fetch('slug')
    end

    def front_box_art
      @front_box_art ||= "#{base_url}#{data.fetch('boxArt')}"
    end

    # TODO: Figure out what the value  returned here actually is.
    def gallery
      @gallery ||= data.fetch('gallery')
    end

    def platform
      @platform ||= data.fetch('platform')
    end

    def release_date
      @release_date ||= Date.parse(data.fetch('releaseDateMask'))
    end

    def characters
      @characters ||= data.fetch('characters')
    end

    def categories
      @categories ||= data.fetch('categories')
    end

    def esrb
      @esrb ||= data.fetch('esrb')
    end

    def esrb_descriptors
      @esrb_descriptors ||= data.fetch('esrbDescriptors')
    end

    def virtual_console
      @virtual_console ||= data.fetch('virtualConsole')
    end

    def general_filters
      @general_filters ||= data.fetch('generalFilters')
    end

    def filter_shops
      @filter_shops ||= data.fetch('filterShops')
    end

    def filter_players
      @filter_players ||= data.fetch('filterPlayers')
    end

    def number_of_players
      @number_of_players ||= data.fetch('players')
    end

    def featured?
      @featured ||= data.fetch('featured')
    end

    def free_to_start?
      @free_to_start ||= data.fetch('freeToStart')
    end

    def price_range
      @price_range ||= data.fetch('priceRange')
    end

    def availability
      @availability ||= data.fetch('availability')
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
