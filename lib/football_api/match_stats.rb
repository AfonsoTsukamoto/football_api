module FootballApi
  class MatchStats
    attr_accessor :id, :local_team_stats, :visitor_team_stats

    def initialize(hash = {})
      @id             = hash[:id]
      @local_team_stats = Stats.new(hash[:localteam])
      @visitor_team_stats = Stats.new(hash[:visitorteam])
    end
  end


  class Stats
    attr_accessor :total_shots, :ongoal_shots, :fouls, :corners, :offsides, :possestiontime,
                  :yellowcards, :redcards, :saves

    def initialize(hash = {})
      @total_shots    = hash[:shots][:total]          if hash[:shots]
      @ongoal_shots   = hash[:shots][:ongoal]         if hash[:shots]
      @fouls          = hash[:fouls][:total]          if hash[:fouls]
      @corners        = hash[:corners][:total]        if hash[:corners]
      @offsides       = hash[:offsides][:total]       if hash[:offsides]
      @possestiontime = hash[:possestiontime][:total] if hash[:possestiontime]
      @yellowcards    = hash[:yellowcards][:total]    if hash[:yellowcards]
      @redcards       = hash[:redcards][:total]       if hash[:redcards]
      @saves          = hash[:saves][:total]          if hash[:saves]
    end
  end
end