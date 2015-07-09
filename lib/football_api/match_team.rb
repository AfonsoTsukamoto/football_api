module FootballApi
  class MatchTeam

    attr_accessor :id, :players

    def initialize(hash = {}, key)
      @id = hash[:comm_match_id]
      @players = parse_players(hash, key)
    end

    def parse_players(hash = {}, key)
      players = []
      Array(hash[:comm_match_teams][key][:player]).each do |player|
        players << FootballApi::Player.new(player)
      end
      Array(hash[:comm_match_subs][key][:player]).each do |player|
        players << FootballApi::Player.new(player)
      end
      players
    end
  end
end