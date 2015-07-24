module FootballApi
  class BaseRequest
    include HTTParty
    include FootballApi::Symbolizer

    debug_output $stdout if ENV.fetch('DEBUG', false)
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
    RETRIES = 3

    # The API Base URI
    base_uri 'http://football-api.com/'

    # The default format of the requests. Used on HTTP header 'Content-Type'.
    format :json

    # The default params for every request
    default_params 'APIKey' => ENV.fetch('API_KEY', '')

    # Default request timeout in seconds. This can be overriden by module configuration.
    default_timeout 15

    class << self

      # The generic get method for all requests.
      # Uses httparty get and makes no assumptions about the response,
      # simply returns it
      def get!(options = {}, &block)
        attempts ||= RETRIES
        query = action_query(options)
        get("/api/", query, &block)

      rescue Timeout::Error => e
        puts "Timeout! Retrying... (#{RETRIES - attempts})"

        retry if (attempts -= 1) > 0

        raise FootballApi::RequestError.new('Request timeout')
      end

      alias_method :request!, :get!

      # This is an handy method for response parsing.
      # Subclasses that include Requestable can simply use the json_key option
      # and response will only contain that field.
      # It also deep symbolizes the response keys
      def response(options = {})
        data = get!(options) || Hash.new

        data = custom_deep_symbolic_hash(data)
        data.present? ? data[json_id] : data
      end

      def action_query(options = {})
        { query: { "Action" => action }.merge(options) }.tap do |hs|
          hs[:query].merge!(get_parameters) if params_method
        end
      end

      def get_parameters
        send(params_method)
      end
    end
  end
end
