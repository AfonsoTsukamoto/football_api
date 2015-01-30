module FootballApi
  class Comment < FootballApi::BaseRequest
    attr_accessor :id, :important, :is_goal, :minute, :comment

    def initialize(hash = {})
      @id        = hash[:id]
      @important = hash[:important]
      @is_goal   = hash[:isgoal]
      @minute    = hash[:minute]
      @comment   = hash[:comment]
    end
  end
end