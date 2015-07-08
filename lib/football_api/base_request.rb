module FootballApi
  class BaseRequest
    include HTTParty
    debug_output $stdout
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
    # TODO : Pass key in config
    default_params 'APIKey' => '69216017-4bb7-96db-0deeadb1b645'

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
        response = get!(options)

        response = Hash.new unless response
        response = deep_symbolize_football_api(response.to_hash.deep_symbolize_keys!)

        response.present? ? response[json_id] : response
      end

      def action_query(options = {})
        { query: { "Action" => action }.merge(options) }.tap do |hs|
          hs[:query].merge!(get_parameters) if params_method
        end
      end

      def get_parameters
        send(params_method)
      end

      # Afonso i need this to go to a mixin but i cant make it work :(
        def hash_or_array_keys
          [:player, :substitution, :comment]
        end

      # Since the goals come as an hash like:
      # => { '1': { ... }, '2': { ... } }
      # the only way to have the score is by interpolating the keys.
      # Ugly? yup! as f*ck!
      def deep_symbolize_football_api(hash)
        {}.tap { |h| hash.each { |key, value| h[key] = map_value(key, value) } }
      end

      def map_value(key, thing)
        case thing
        when Array
          thing.map { |v| map_value(nil, v) }
        when Hash
          return deep_symbolize_football_api(thing) unless hash_or_array_keys.include?(key)
          map_value(nil, array_or_hash_with_indiferent_access(thing))
        else
          thing
        end
      end

      def array_or_hash_with_indiferent_access(hash = {})
        return [] if !hash.is_a?(Hash)

        hash.keys.map do |key|
          if (key.to_s =~ /[0-9]/) != nil
            hash[key]
          else
            return [hash]
          end
        end
      end
    end
  end
end