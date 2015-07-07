module FootballApi
  class Standing < FootballApi::BaseRequest
    include FootballApi::Requestable

    api_options action: :standings, action_params: :standing_params, json_key: :teams

    class << self
      attr_accessor :competition_id

      def all_from_competition(competition)
        self.competition_id = competition.is_a?(Competition) ? competition.id : competition

        response.map{ |standing| new(standing) }
      end

      def standing_params
        { comp_id: self.competition_id }
      end
    end

    # Response sample :
    # [
    #   {
    #     "stand_id"=>"12049092",
    #     "stand_competition_id"=>"1204",
    #     "stand_season"=>"2014/2015",
    #     "stand_round"=>"22",
    #     "stand_stage_id"=>"12041081",
    #     "stand_group"=>"",
    #     "stand_country"=>"England",
    #     "stand_team_id"=>"9092",
    #     "stand_team_name"=>"Chelsea",
    #     "stand_status"=>"same",
    #     "stand_recent_form"=>"WWLDW",
    #     "stand_position"=>"1",
    #     "stand_overall_gp"=>"22",
    #     "stand_overall_w"=>"16",
    #     "stand_overall_d"=>"4",
    #     "stand_overall_l"=>"2",
    #     "stand_overall_gs"=>"51",
    #     "stand_overall_ga"=>"19",
    #     "stand_home_gp"=>"10",
    #     "stand_home_w"=>"10",
    #     "stand_home_d"=>"0",
    #     "stand_home_l"=>"0",
    #     "stand_home_gs"=>"24",
    #     "stand_home_ga"=>"3",
    #     "stand_away_gp"=>"12",
    #     "stand_away_w"=>"10",
    #     "stand_away_d"=>"0",
    #     "stand_away_l"=>"0",
    #     "stand_away_gs"=>"24",
    #     "stand_away_ga"=>"3",
    #     "stand_gd"=>"32",
    #     "stand_points"=>"52",
    #     "stand_desc"=>"Promotion - Champions League (Group Stage)"
    #   }, ...
    # ]

    attr_accessor :stand_id, :stand_competition_id, :stand_season, :stand_round, :stand_stage_id,
                  :stand_group, :stand_country, :stand_team_id, :stand_team_name, :stand_status,
                  :stand_recent_form, :stand_position, :stand_overall_gp, :stand_overall_w,
                  :stand_overall_d, :stand_overall_l, :stand_overall_gs, :stand_overall_ga,
                  :stand_home_gp, :stand_home_w, :stand_home_d, :stand_home_l, :stand_home_gs,
                  :stand_home_ga, :stand_away_gp, :stand_away_w, :stand_away_d, :stand_away_l,
                  :stand_away_gs, :stand_away_ga, :stand_gd, :stand_points, :stand_desc

    def initialize(hash = {})
      @stand_id             = hash[:stand_id]
      @stand_competition_id = hash[:stand_competition_id]
      @stand_season         = hash[:stand_season]
      @stand_round          = hash[:stand_round]
      @stand_stage_id       = hash[:stand_stage_id]
      @stand_group          = hash[:stand_group]
      @stand_country        = hash[:stand_country]
      @stand_team_id        = hash[:stand_team_id]
      @stand_team_name      = hash[:stand_team_name]
      @stand_status         = hash[:stand_status]
      @stand_recent_form    = hash[:stand_recent_form]
      @stand_position       = hash[:stand_position]
      @stand_overall_gp     = hash[:stand_overall_gp]
      @stand_overall_w      = hash[:stand_overall_w]
      @stand_overall_d      = hash[:stand_overall_d]
      @stand_overall_l      = hash[:stand_overall_l]
      @stand_overall_gs     = hash[:stand_overall_gs]
      @stand_overall_ga     = hash[:stand_overall_ga]
      @stand_home_gp        = hash[:stand_home_gp]
      @stand_home_w         = hash[:stand_home_w]
      @stand_home_d         = hash[:stand_home_d]
      @stand_home_l         = hash[:stand_home_l]
      @stand_home_gs        = hash[:stand_home_gs]
      @stand_home_ga        = hash[:stand_home_ga]
      @stand_away_gp        = hash[:stand_away_gp]
      @stand_away_w         = hash[:stand_away_w]
      @stand_away_d         = hash[:stand_away_d]
      @stand_away_l         = hash[:stand_away_l]
      @stand_away_gs        = hash[:stand_away_gs]
      @stand_away_ga        = hash[:stand_away_ga]
      @stand_gd             = hash[:stand_gd]
      @stand_points         = hash[:stand_points]
      @stand_desc           = hash[:stand_desc]
    end
  end
end