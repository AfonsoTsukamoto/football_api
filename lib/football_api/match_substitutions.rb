module FootballApi
  class MatchSubstitutions
    def initialize(hash = {})
      @match_id     = hash[:match_id]
      @local_team   = subs(hash, :localteam)
      @visitor_team = subs(hash, :visitorteam)
    end

    def subs(hash, key)
      return unless hash[key]

      Hash(hash[key][:substitution]).values.map do |s|
        Substitution.new(s)
      end
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
