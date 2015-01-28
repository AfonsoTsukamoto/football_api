module FootballApi
  class Event
    attr_accessor :event_id, :event_match_id, :event_type, :event_minute, :event_team,
                  :event_player, :event_player_id, :event_result

    def initialize(hash = {})
      @event_id        = hash[:event_id]
      @event_match_id  = hash[:event_match_id]
      @event_type      = hash[:event_type]
      @event_minute    = hash[:event_minute]
      @event_team      = hash[:event_team]
      @event_player    = hash[:event_player]
      @event_player_id = hash[:event_player_id]
      @event_result    = hash[:event_result]
    end
  end
end