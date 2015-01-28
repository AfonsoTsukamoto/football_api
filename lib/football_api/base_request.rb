module FootballApi
  class BaseRequest
    include HTTParty

    # Disable the use of rails query string format.
    #
    # With rails query string format enabled:
    #   => get '/', :query => { selected_ids: [1,2,3] }
    #
    # Would translate to this:
    #   => /?selected_ids[]=1&selected_ids[]=2&selected_ids[]=3
    #
    disable_rails_query_string_format

    # How many times should we retry the request if Timeout::Error is raised?
    RETRIES = 5

    # The API Base URI
    base_uri 'http://football-api.com/'

    # The default format of the requests. Used on HTTP header 'Content-Type'.
    format :json

    # The default params for every request
    # TODO : Pass key in config
    default_params 'APIKey' => ''

    # Default request timeout in seconds. This can be overriden by module configuration.
    default_timeout 15

    class << self

      # The generic get method for all requests.
      # Uses httparty get and makes no assumptions about the response,
      # simply returns it
      def get!(options = {}, &block)
        attempts ||= RETRIES
        get("/api/", action_query(options), &block)
      rescue Timeout::Error => e
        puts "Timeout! Retrying... (#{RETRIES - attempts})"
        (attempts -= 1) > 0 ? retry : raise(FootballApi::RequestError.new, 'Request timeout')
      end

      alias_method :request!, :get!

      # This is an handy method for reponse parsing.
      # Subclasses that include Requestable can simply use the json_key option
      # and responde will only contain that field.
      # It also deep symbolizes the response keys in order to keep things more 'ruby-way'
      def response(options = {})
        binding.pry
        response = get!
        binding.pry
        response.deep_symbolize_keys!

        (json_id && response[json_id]) ? response[json_id] : []
      end

      def action_query(options = {})
        query = { query: { "Action" => action }.merge(options) }
        query[:query].merge!(params_from_method) if params_from_method
        query
      end

      def params_from_method
        self.params_method ? send(params_method) : nil
      end
    end
  end
end
