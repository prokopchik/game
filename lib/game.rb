class Game
  def initialize(items, player1, player2)
    @player1, @player2 = player1, player2
    beats_count = (items.size - 1) / 2
    player1_index = items.index(@player1.pick)

    start_index = player1_index + 1
    end_index = player1_index + beats_count
    @beats = (items + items)[start_index..end_index]
  end

  def winner
    return 'Draw' if same_pick?
    player1_win? ? @player1.name : @player2.name
  end

  def same_pick?
    @player1.pick == @player2.pick
  end

  def player1_win?
    @beats.include?(@player2.pick)
  end
end
