module FootballApi
  class Player
    attr_accessor :number, :name, :pos, :id

    def initialize(hash = {})
      @number = hash[:number]
      @name   = hash[:name]
      @pos    = hash[:pos]
      @id     = hash[:id]
    end
  end
end