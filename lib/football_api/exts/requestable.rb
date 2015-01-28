module FootballApi
  module Requestable
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      attr_accessor :action, :json_id, :params_method

      ##
      # Options can be any of the class attributes
      def api_options(options = {})
        self.action  = options.delete(:action).to_s if options[:action]
        self.json_id = options.delete(:json_key) if options[:json_key]
        self.params_method = options.delete(:action_params)
      end
    end
  end
end