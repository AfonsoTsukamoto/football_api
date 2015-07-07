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

    # Since the goals come as an hash like:
    # => { '1': { ... }, '2': { ... } }
    # the only way to have the score is by interpolating the keys.
    # Ugly? yup! as f*ck!
    def parse_team_goals(hash = {})
      return [] if !hash[:goals] || hash[:goals].is_a?(Array) || !hash[:goals][:player]

      hash[:goals][:player].keys.map do |score|
        if (score.to_s =~ /[0-9]/) != nil
          FootballApi::Goal.new(hash[:goals][:player][score].merge(score: score.to_s.to_i))
        else
          FootballApi::Goal.new(hash[:goals][:player])
        end
      end
    end

    # If the cards struct has no members, its type is an array, so we must do
    # the type validation before sending it to new.
    # Like with the goals, the only way to iterpolate through all the records
    # is with the hash key.
    def parse_cards(hash, type)
      return [] if !hash.is_a?(Hash)

      hash.keys.map do |key|
        FootballApi::Card.new(hash[key].merge(type: type))
      end
    end
  end
end