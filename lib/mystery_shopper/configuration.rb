module MysteryShopper
  class Configuration
    attr_accessor :application_id, :api_key

    def initialize
      @application_id = nil
      @api_key        = nil
    end
  end
end
