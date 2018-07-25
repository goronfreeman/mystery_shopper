require 'mystery_shopper/game'

module MysteryShopper
  class Response
    def initialize(data)
      @data = data
    end

    def games
      data.fetch('games', []).fetch('game', []).map { |game| Game.new(game) }
    end

    private

    attr_reader :data
  end
end
