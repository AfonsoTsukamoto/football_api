module FootballApi
  class MatchTeam
    def initialize(hash = {})
      @id = hash.delete(:id)
      @players = parse_players(hash)
    end

    def parse_players(hash = {})
      Array(hash[:player]).map { |player| FootballApi::Player.new(player) }
    end
  end
end