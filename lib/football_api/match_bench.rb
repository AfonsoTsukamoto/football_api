module FootballApi
  class MatchBench

    attr_accessor :match_id, :local_team, :visitor_team

    def initialize(hash = {})
      @match_id     = hash[:match_id]
      @local_team   = Bench.new(hash, :localteam)
      @visitor_team = Bench.new(hash, :visitorteam)
    end
  end

  class Bench

    attr_accessor :team, :players

    def initialize(opts = {}, key)
      # XXX - Use case for more than one player, might be different
      # Api returns single object without number index on single occurrence.
      opts = opts[key]
      return unless opts.present?

      @team = key
      @players = Array(opts[:player]).map { |v| Player.new(v) }
    end
  end
end
