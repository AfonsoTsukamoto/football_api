module FootballApi
  module Symbolizer
    def self.included(base)
      base.extend(ClassMethods)
    end

    HASH_OR_ARRAY_KEYS = [:player, :substitution, :comment].freeze
    module ClassMethods
      # Since the goals come as an hash like:
      # Custom deep symbolize of an hash
      # So we can override the mess of some footbal-api arrays
      def custom_deep_symbolic_hash(hash)
        {}.tap do |h|
          Hash(hash).each do |key, value|
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
      def map_value(key, thing)
        case thing
        when Array
          thing.map { |v| map_value(nil, v) }
        when Hash
          return custom_deep_symbolic_hash(thing) unless is_a_custom_key?(key)
          map_value(nil, array_from_mess(thing))
        else
          thing
        end
      end

      def is_a_custom_key?(key)
        HASH_OR_ARRAY_KEYS.include?(key)
      end

      # Since the custom keys come as an hash like:
      # => { '1': { ... }, '2': { ... } }
      # OR!
      # A simple object from the root
      # We need to unify the return value and return a simple array of objects
      # Ugly? yup! as f*ck!
      def array_from_mess(hash)
        hash.keys.map do |key|
          return [hash] unless (key.to_s =~ /[0-9]/)
          hash[key]
        end
      end
    end
  end
end
