module FootballApi
  class Commentary < FootballApi::BaseRequest
    include FootballApi::Requestable

    api_options action: :commentaries, action_params: :commentary_params, json_key: :commentaries

    class << self
      attr_accessor :match_id

      def all_from_match(match)
        @match_id = match.is_a?(Match) ? match.id : match

        res = response
        res.map { |commentary| new(commentary) }.first
      end

      def commentary_params
        { match_id: self.match_id }
      end
    end

    attr_accessor :match_id, :static_id, :match_info, :match_summary,
                  :match_stats, :local_match_team, :visitor_match_team,
                  :commentaries, :match_bench, :match_substitutions

    def initialize(hash = {})
      @match_id            = hash[:comm_match_id]
      @static_id           = hash[:comm_static_id]
      @match_info          = parse_match_info(hash)
      @match_summary       = parse_match_summary(hash)
      @match_stats         = parse_match_stats(hash)
      @local_match_team    = parse_match_teams(hash, :localteam)
      @visitor_match_team  = parse_match_teams(hash, :visitorteam)
      @match_bench         = parse_match_bench(hash)
      @match_substitutions = parse_match_substitutions(hash)
      @commentaries        = parse_comments(hash[:comm_commentaries])
    end

    def parse_match_info(hash = {})
      hash = hash[:comm_match_info].merge(id: hash[:comm_match_id])
      FootballApi::MatchInfo.new(hash)
    end

    def parse_match_summary(hash = {})
      hash = hash[:comm_match_summary].merge(id: hash[:comm_match_id])
      FootballApi::MatchSummary.new(hash)
    end

    def parse_match_stats(hash = {})
      return unless hash[:comm_match_stats].is_a?(Hash)
      hash = hash[:comm_match_stats].merge(id: hash[:comm_match_id])
      FootballApi::MatchStats.new(hash)
    end

    def parse_match_teams(hash = {}, key)
      team_hash = hash[:comm_match_teams][key]      unless hash[:comm_match_teams][key].blank?
      team_hash.merge!(hash[:comm_match_subs][key]) unless hash[:comm_match_subs][key].blank?
      team_hash.merge!(id: hash[:comm_match_id])
      FootballApi::MatchTeam.new(team_hash)
    end

    def parse_comments(hash = {})
      return unless hash[:comment]

      Array(hash[:comment]).map{ |comment| FootballApi::Comment.new(comment) }
    end

    def parse_match_bench(hash = {})
      return unless hash[:comm_match_subs]

      FootballApi::MatchBench.new(hash[:comm_match_subs]
                                  .merge(match_id: hash[:comm_match_id]))
    end

    def parse_match_substitutions(hash)
      return unless hash[:comm_match_substitutions]

      FootballApi::MatchSubstitutions.new(hash[:comm_match_substitutions]
                                          .merge(match_id: hash[:comm_match_id]))
    end
  end
end
