module FootballApi
  class Match < FootballApi::BaseRequest
    include FootballApi::Requestable

    api_options action: :today,
                action_params: :match_params,
                json_key: :matches

    class << self
      attr_accessor :competition_id

      def today
        @competition_id = nil
        collection(response)
      end

      def all_from_competition(competition)
        @competition_id = competition.is_a?(Competition) ? competition.id : competition
        collection(response)
      end

      def collection(json)
        json = json[:matches] || json
        Array(json).map{ |el| new(el) }
      end

      def match_params
        self.competition_id ? { comp_id: self.competition_id} : {}
      end
    end

    attr_accessor :match_id, :static_id, :match_comp_id, :match_date,
                  :match_formatted_date, :match_status, :match_time,
                  :match_commentary_available, :match_ht_score,
                  :match_localteam_id, :match_localteam_name,
                  :match_localteam_score, :match_visitorteam_id,
                  :match_visitorteam_name, :match_visitorteam_score,
                  :match_venue_city_beta, :match_venue_id_beta,
                  :match_venue_beta, :match_week_beta, :match_season_beta,
                  :match_et_score, :match_ft_score, :match_events


    def initialize(hash = {})
      @match_id                   = hash[:match_id]
      @static_id                  = hash[:match_static_id]
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
      @match_ft_score             = hash[:match_ft_score]
      @match_et_score             = hash[:match_et_score]
      @match_season_beta          = hash[:match_season_beta]
      @match_week_beta            = hash[:match_week_beta]
      @match_venue_beta           = hash[:match_venue_beta]
      @match_venue_id_beta        = hash[:match_venue_id_beta]
      @match_venue_city_beta      = hash[:match_venue_city_beta]
      @match_events               = parse_match_events(hash[:match_events])
    end

    def parse_match_events(arr = [])
      Array(arr).map { |e| FootballApi::Event.new(e) }
    end
  end
end
