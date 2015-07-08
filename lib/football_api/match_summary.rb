module FootballApi
  class MatchSummary

    attr_accessor :id, :local_team_goals, :local_team_yellowcards, :local_team_redcards,
                  :visitor_team_goals, :visitor_team_yellowcards, :visitor_team_redcards

    # For the teams goals, the api returns an empty array
    # when there are no goals.
    # Goals is an hash if there are goals to present.
    def initialize(hash = {})
      @id = hash[:id]

      @local_team_goals = parse_team_goals(hash[:localteam])
      @local_team_yellowcards = parse_cards(hash[:localteam][:yellowcards], :yellow)
      @local_team_redcards = parse_cards(hash[:localteam][:redcards], :red)

      @visitor_team_goals = parse_team_goals(hash[:visitorteam])
      @visitor_team_yellowcards = parse_cards(hash[:visitorteam][:yellowcards], :yellow)
      @visitor_team_redcards = parse_cards(hash[:visitorteam][:redcards], :red)
    end

    def parse_team_goals(hash = {})
      return [] if !hash[:goals] || hash[:goals].is_a?(Array) || !hash[:goals][:player]

      Array(hash[:goals][:player]).map do |player|
        FootballApi::Goal.new(player.merge(score: player.to_s.to_i))
      end
    end

    # If the cards struct has no members, its type is an array, so we must do
    # the type validation before sending it to new.
    # Like with the goals, the only way to iterpolate through all the records
    # is with the hash key.
    def parse_cards(hash, type)
      return [] if !hash.is_a?(Hash) || !hash[:player]
      Array(hash[:player]).map { |card| FootballApi::Card.new(card.merge(type: type)) }
    end
  end
end
