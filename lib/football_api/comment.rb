module FootballApi
  class Comment < FootballApi::BaseRequest
    attr_accessor :id, :important, :is_goal, :minute, :comment

    def initialize(hash = {})
      @id        = hash[:id]
      @important = hash[:important]
      @is_goal   = hash[:isgoal]
      @minute    = parse_minute(hash)
      @comment   = hash[:comment]
    end

    private
    def parse_minute(hash)
      hash[:minute].to_i
    end
  end
end