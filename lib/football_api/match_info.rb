module FootballApi
  class MatchInfo

    attr_accessor :stadium_name, :attendance, :time, :referee, :id

    def initialize(hash = {})
      @id           = hash[:id]
      @stadium_name = hash[:stadium][:name]    if hash[:stadium]
      @attendance   = hash[:attendance][:name] if hash[:attendance]
      @time         = hash[:time][:name]       if hash[:time]
      @referee      = hash[:referee][:name]    if hash[:referee]
    end
  end
end