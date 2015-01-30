module FootballApi
  class MatchTeam
    def initialize(hash = {})
      @id = hash.delete(:id)
      @players = parse_players(hash)
    end

    def parse_players(hash = {})
      hash.keys.map{ |k|
        FootballApi::Player.new(hash[k])
      }
    end
  end
end