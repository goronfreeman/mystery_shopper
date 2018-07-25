require 'date'
require 'datetime'

module MysteryShopper
  class Price
    def initialize(data)
      @data = data
    end

    def title_id
      @title_id ||= data.fetch('title_id')
    end

    def sales_status
      @sales_status ||= data.fetch('sales_status')
    end

    def regular_price
      @regular_price ||= data.dig('regular_price', 'raw_value').to_f
    end

    def discount_price
      @discount_price ||= discount.fetch('raw_value').to_f
    end

    def sale_start
      @sale_start ||= DateTime.parse(discount.fetch('start_datetime'))
    end

    def sale_end
      @sale_end ||= DateTime.parse(discount.fetch('end_datetime'))
    end

    private

    attr_reader :data

    def discount
      @discount ||= data.fetch('discount_price')
    end
  end
end
