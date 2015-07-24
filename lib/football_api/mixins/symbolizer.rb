module FootballApi
  module Symbolizer
    def self.included(base)
      base.extend(ClassMethods)
    end

    HASH_OR_ARRAY_KEYS = [:player, :substitution, :comment, :match_events].freeze

    module ClassMethods
      # Custom deep symbolize of an hash
      # So we can override the mess of some footbal-api arrays
      def custom_deep_symbolic_hash(hash)
        {}.tap do |h|
          Hash.new(hash).each do |key, value|
            key = symbolyze_key(key)
            h[key] = map_value(key, value)
          end
        end
      end

      private

      # Convert key to symbol
      def symbolyze_key(key)
        key.to_sym rescue key
      end

      # Recursive way of checking all hash
      def map_value(key, value)
        case value
        when Array
          value.map { |v| map_value(nil, v) }
        when Hash
          return custom_deep_symbolic_hash(value) unless is_a_custom_key?(key)
          map_value(nil, array_from_mess(value))
        else
          value
        end
      end

      def is_a_custom_key?(key)
        HASH_OR_ARRAY_KEYS.include?(key)
      end

      # Since the custom keys come as an hash like: => { '1': { ... }, '2': { ... } }
      # OR!
      # A simple object from the root
      # We need to unify the return value and return a simple array of objects
      # Ugly? yup! as f*ck!
      def array_from_mess(hash)
        return key_contains_object?(hash.keys.first) ? [hash] : hash.values
      end

      def key_contains_object?(key)
        (key.to_s =~ /[0-9]/) == nil
      end
    end
  end
end
