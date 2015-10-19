class Game

  attr_accessor :player1, :playerA
  attr_reader :moves

  WINNING_LINES = [ [0,1,2], [3,4,5], [6,7,8], 
                    [0,3,6], [1,4,7], [2,5,8], 
                    [0,4,8], [2,4,6] ]

  def initialize
    @moves = []
  end

  def make_move(player, square)
    if square < 0
      puts "Your move was too low, Doofus!"
      puts "Hit enter to try again"
      gets
    elsif square > 8
      puts "Your move was too high, Doofus!"
      puts "Hit enter to try again"
      gets
    elsif board[square] 
      puts "Your move has already been played, Doofus!"
      puts "Hit enter to try again"
      gets
    else
      @moves << Move.new(player, square, symbol_for_player(player))
    end
  end

  def finished?
    winning_game? || drawn_game?
  end

  def result
    case
    when winning_game?
      "#{moves.last.player} won!

*** CONGRATULATIONS SIMON! YOU WON ***"
    when drawn_game?
      "It is a draw! 

*** CONGRATULATIONS SIMON! YOU WON ***"
    else 
      "The game is still in progress...

*** CONGRATULATIONS SIMON! YOU WON ***"
    end
  end

  def whose_turn
    return player1 if moves.empty?
    moves.last.player == player1 ? playerA : player1
  end

  def empty_board
    Array.new(9,nil)
  end

  def board
    empty_board.tap do |board|
      moves.each do |move|
        board[move.square] = move.symbol
      end
    end
  end

  private
  def winning_game?
    !!WINNING_LINES.detect do |winning_line|
      %w(XXX OOO).include?(winning_line.map { |e| board[e] }.join)
    end
  end

  private
  def drawn_game?
    moves.size == 9
  end

  private
    def symbol_for_player(player)
      case player
      when player1
        'X'
      when playerA
        'O'
      else
        raise "OI! Jog on, mate! This is one on one!"
      end
    end

end