module FootballApi
  class MatchSubstitutions
    def initialize(hash = {})
      @match_id     = hash[:match_id]
      @local_team   = subs(hash, :localteam)
      @visitor_team = subs(hash, :visitorteam)
    end

    def subs(hash, key)
      return [] unless hash[key]
      Array(hash[key][:substitution]).map { |s| Substitution.new(s) }
    end
  end

  class Substitution
    def initialize(opts = {})
      @off    = opts[:off]
      @on     = opts[:on]
      @minute = opts[:minute]
      @on_id  = opts[:on_id]
      @off_id = opts[:off_id]
    end
  end
end
