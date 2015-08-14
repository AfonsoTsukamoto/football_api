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

        collection(response)
      end

      def collection(json)
        Array(json).map{ |el| new(el) }
      end

      def fixture_params
        [:comp_id, :match_date, :from_date, :to_date].each_with_object({}) do |symb, opts|
          opts.merge!(symb => send(symb) ) if send(symb)
        end
      end
    end

    attr_accessor :match, :match_timer, :match_events

    def initialize(hash = {})
      @match                      = parse_match(hash)
      @match_timer                = hash[:match_timer]
      @match_events               = parse_match_events(hash[:match_events])
    end

    def parse_match(hash = {})
      FootballApi::Match.new(hash)
    end

    def parse_match_events(arr = [])
      Array(arr).map { |e| FootballApi::Event.new(e) }
    end
  end
end