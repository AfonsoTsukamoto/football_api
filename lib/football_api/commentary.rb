module FootballApi
  class Commentary
    include FootballApi::Requestable

    api_options action: :commentaries, action_params: :commentary_params, json_key: :commentaries

    class << self
      attr_accessor :match_id

      def self.all_from_match(match)
        self.match_id = match.is_a?(Match) ? match.id : match
        response.map{ |commentary|
          new(commentary.first)
        }
      end
    end

    def initialize(hash = {})
      @comm_match_id      = hash[:comm_match_id]
      @comm_static_id     = hash[:comm_static_id]
      @comm_match_info    = parse_match_info(
        hash[:comm_match_info].merge(id: hash[:comm_match_id]))
      @comm_match_summary = parse_match_summary(
        hash[:comm_match_summary].merge(id: hash[:comm_match_id])
    end


    def match_info(hash = {})
      FootballApi::MatchInfo.new(hash)
    end
  end
end