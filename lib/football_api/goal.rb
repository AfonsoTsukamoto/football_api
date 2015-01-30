module FootballApi
  class Goal
    attr_accessor :score, :minute, :player, :owngoal, :penalty

    def initialize(hash = {})
      @score = hash[:score]
      @minute = hash[:minute]
      @owngoal = hash[:owngoal]
      @penalty = hash[:penalty]
      @player = parse_player(hash)
    end

    def parse_player(hash = {})
      FootballApi::Player.new(hash)
    end
  end
end
