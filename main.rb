require 'pry-byebug'

require_relative 'game'
require_relative 'move'

puts `clear`
puts "Playing Tic Tac Toe..."
puts "Or Naughts and Crosses..."


def expect(thing, other_thing)
  raise "Dun goofed... #{thing} did not equal #{other_thing}" unless thing == other_thing
end

def print_board(g)
  puts(g.board.each_slice(3).map do |row|
        row.map { |e| e || ' ' }.join(' | ')
      end.join("\n---------\n"))
end

g = Game.new


expect g.class.name, "Game"

expect g.moves, []

g.player1 = "Michael"
g.playerA = "Neil"

expect g.player1, 'Michael'
expect g.playerA, 'Neil'

g.make_move 'Michael', 4

expect g.moves.last.class.name, "Move"

expect g.moves.last.player, "Michael"
expect g.moves.last.square, 4
expect g.moves.last.symbol, "X"


g.make_move 'Neil', 0

expect g.moves.last.player, "Neil"
expect g.moves.last.square, 0
expect g.moves.last.symbol, "O"

expect g.finished?, false

g.make_move 'Michael', 8
g.make_move 'Neil', 3
g.make_move 'Michael', 2
g.make_move 'Neil', 6

expect g.finished?, true

expect g.result, "Neil won!

*** CONGRATULATIONS SIMON! YOU WON ***"

g = Game.new

puts "What is Player 1's name? "
g.player1 = gets.chomp
if g.player1.empty?
  g.player1 = "Player 1"
end
puts
puts "What is Player A's name? "
g.playerA = gets.chomp
if g.playerA.empty?
  g.playerA = "Player A"
end

if g.player1 == g.playerA
  g.player1 = "#{g.player1}1"
  g.playerA = "#{g.playerA}A"
end

until g.finished?
  puts `clear`
  puts "Remember the boxes go:"
  puts "0 | 1 | 2"
  puts "---------"
  puts "3 | 4 | 5"
  puts "---------"
  puts "6 | 7 | 8"
  puts
  puts print_board(g)
  puts
  puts "#{g.whose_turn}, make your move:"
  print "--> "
  input = gets.chomp
  if input =~ /[[:digit:]]/
    g.make_move g.whose_turn, input.to_i
  else
    puts "Your move was invalid, Doofus!"
    puts "Enter a number from 0 to 8!"
    puts "Press enter to continue"
    gets
  end
  
end

puts `clear`
puts print_board(g)
puts
puts g.result

# binding.pry;''