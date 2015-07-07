# Automatically loads json files with an associated class for loading fixture
module JSONHelper
  class << self
    # Uhuhuh! What a cache!
    def cache
      @cache ||= {}
    end

    def cache_or_load(path)
      cache[path] ||= begin
        file = File.read(path)
        JSON.parse(file).symbolize_keys
      end
    end

    def load_file(name)
      path = File.expand_path("../../json/#{name}", __FILE__)
      cache_or_load(path)
    end
  end

  # TODO: Better way to deal with this.
  # Declaring a class for each one was too much.
  # With this, it works, but is too meta, I think.
  class Generic
    def self.get(name)
      new.get(name)
    end

    def get(name)
      file_name = "#{File.basename(self.class.name.underscore)}.json"
      fixtures = ::JSONHelper.load_file(file_name)
      fixtures[name.to_sym].clone
    end
  end

  Dir[File.expand_path('../../json/*.json', __FILE__)].each do |file_name|
    klass_name = "#{File.basename(file_name, '.json').camelize}"
    JSONHelper.const_set(klass_name, Class.new(Generic))
  end
end
