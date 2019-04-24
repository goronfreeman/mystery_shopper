require 'mystery_shopper/game'

module MysteryShopper
  class Response
    def initialize(data)
      @data = data
    end

    def games
      data.dig('results', 0, 'hits').map { |game| Game.new(game) }
    end

    private

    attr_reader :data
  end
end
