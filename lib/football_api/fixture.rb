module FootballApi
  class Fixture < FootballApi::BaseRequest
    include FootballApi::Requestable

    api_options action: :fixtures, action_params: :fixture_params, json_key: :matches

    class << self
      attr_accessor :match_date, :from_date, :to_date, :comp_id

      def where(options = {})
        @comp_id = options.delete(:comp_id)
        @match_date = options.delete(:match_date)
        @from_date = options.delete(:from_date)
        @to_date = options.delete(:to_date)

        response.map{ |fixture|
          new (fixture)
        }
      end

      def fixture_params
        [:comp_id, :match_date, :from_date, :to_date].each_with_object({}) do |symb, opts|
          opts.merge!(symb => send(symb) ) if send(symb)
        end
      end
    end

    attr_accessor :match_id, :match_static_id, :match_comp_id, :match_date, :match_formatted_date,
                  :match_status, :match_timer, :match_time, :match_commentary_available,
                  :match_localteam_id, :match_localteam_name, :match_localteam_score,
                  :match_visitorteam_id, :match_visitorteam_name, :match_visitorteam_score,
                  :match_ht_score, :match_ft_score, :match_et_score, :match_season_beta,
                  :match_week_beta, :match_venue_beta, :match_venue_id_beta, :match_venue_city_beta,
                  :match_events

    def initialize(hash = {})
      @match_id                   = hash[:match_id]
      @match_static_id            = hash[:match_static_id]
      @match_comp_id              = hash[:match_comp_id]
      @match_date                 = hash[:match_date]
      @match_formatted_date       = hash[:match_formatted_date]
      @match_status               = hash[:match_status]
      @match_timer                = hash[:match_timer]
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
      Array(arr).map{ |e|
        FootballApi::Event.new(e)
      }
    end
  end
end