class Player
  attr_reader :pick, :name

  def initialize(name)
    @name = name
  end

  def picks(pick)
    @pick = pick
  end
end