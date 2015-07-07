module FootballApi
  class Competition < FootballApi::BaseRequest
    include FootballApi::Requestable

    api_options action: :competitions, json_key: :Competition

    # Response sample :
    # [
    #   {
    #     "id":"1064",
    #     "name":"Superliga",
    #     "region":"Albania"
    #   } ...
    # ]
    attr_accessor :id, :name, :region

    def self.all
      response && response.map do |comp|
        new(comp)
      end
    end

    def self.where(options = {})
      response.select{ |c| matches_options(c, options) }.map{ |hsh| new(hsh) }
    end

    def initialize(hash = {})
      @id     = hash[:id]
      @name   = hash[:name]
      @region = hash[:region]
    end

    private

    # Matches the two given hashes.
    # For example, if an options hash has:
    #     => {id:1, name: 'ze'}
    #
    # And the object has:
    #     => {id:1, name: 'ze', region: 'beira'}
    #
    # This function returns the reduce(:&) from the array:
    # [true, true, true] -> true
    #
    # Where the two first trues are from *id == id* and *name == name*
    # and since the options hash has no key :region,
    # it returns *true* since that's a non searched option
    def matches_options(object, options)
      options.keys.map{ |key|
        object.has_key?(key) ? options[key] == object[key] : true
      }.reduce(:&)
    end
  end
end