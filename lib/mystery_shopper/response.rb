require 'json'

module MysteryShopper
  class Response
    def initialize(data)
      @data = JSON.parse(data)
    end

    def games
      data.fetch('games').map { |game| Game.new(game) }
    end

    private

    attr_reader :data
  end
end
