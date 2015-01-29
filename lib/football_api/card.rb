module FootballApi
  class Card
    TYPE = [ :yellow, :red ]

    attr_accessor :type, :minute, :player

    def initialize(hash = {})
      return {} unless TYPE.include?(hash[:type])
      @type = hash[:type]
      @minute = hash[:minute]
      @player = parse_player(hash)
    end

    def parse_player(hash = {})
      FootballApi::Player.new(hash)
    end
  end
end