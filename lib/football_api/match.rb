module FootballApi
  class Match < FootballApi::BaseRequest
    include FootballApi::Requestable

    api_options action: :today, action_params: :match_params, json_key: :matches

    class << self
      attr_accessor :competition_id

      def all_from_competition(competition)
        self.competition_id = competition.is_a?(Competition) ? competition.id : competition
        response.map{ |match|
          new(match)
        }
      end

      def match_params
        { comp_id: self.competition_id}
      end
    end

    attr_accessor :match_id, :match_comp_id, :match_date, :match_formatted_date, :match_status,
                  :match_time, :match_commentary_available, :match_localteam_id,
                  :match_localteam_name, :match_localteam_score, :match_visitorteam_id,
                  :match_visitorteam_name, :match_visitorteam_score, :match_ht_score

    def initialize(hash = {})
      @match_id                   = hash[:match_id]
      @match_comp_id              = hash[:match_comp_id]
      @match_date                 = hash[:match_date]
      @match_formatted_date       = hash[:match_formatted_date]
      @match_status               = hash[:match_status]
      @match_time                 = hash[:match_time]
      @match_commentary_available = hash[:match_commentary_available]
      @match_localteam_id         = hash[:match_localteam_id]
      @match_localteam_name       = hash[:match_localteam_name]
      @match_localteam_score      = hash[:match_localteam_score]
      @match_visitorteam_id       = hash[:match_visitorteam_id]
      @match_visitorteam_name     = hash[:match_visitorteam_name]
      @match_visitorteam_score    = hash[:match_visitorteam_score]
      @match_ht_score             = hash[:match_ht_score]
    end
  end
end
