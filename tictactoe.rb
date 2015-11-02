# from solution
require 'pry'

game_ending_messages = {'Player1' => "You have won. Your computer Overlords are not pleased. Not pleased at all. . .",
  'Computer' => 'The Computer won. SkyNet rulz! Take that flesh sack!', 'Player1' => 'You won, but your cat hates you.',
  'Computer' => 'Play a computer, lose like a sissy - what\'d you expect?'}

def initialize_board(show_space_numbers_bool)
  board = {}
  if !show_space_numbers_bool
    (1..9).each { |pos| board[pos] = ' '} 
  else
    (1..9).each { |pos| board[pos] = pos }
  end
  board
end

def draw_board(b)
  system('clear')
  puts "  #{b[1]}  |  #{b[2]}  |  #{b[3]}  "
  puts "-----------------"
  puts "  #{b[4]}  |  #{b[5]}  |  #{b[6]}"
  puts "-----------------"
  puts "  #{b[7]}  |  #{b[8]}  |  #{b[9]} "
end

def player_select_square(board)
  if empty_squares(board).length == 9
    puts 'Pick a square:[1 - 9]:'
    position = gets.chomp.to_i
    board[position] = 'X'
  else 
    begin
      puts "Please select an available square: #{empty_squares(board).keys}:"
      position = gets.chomp.to_i
    end until empty_squares(board).include?(position)
    board[position] = 'X'
  end
end

def empty_squares(board)
  board.select {|k,v| v == ' '}
end

def computer_select_square(board)
  board[empty_squares(board).keys.sample] = 'O' 
end

def check_winner(board)
  winning_lines = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,6,9],[3,5,7]]
  winning_lines.each do |line|
    if board[line[0]] == 'X' and board[line[1]] == 'X' and board[line[2]] == 'X'
      return 'Player1'
    elsif board[line[0]] == 'O' and board[line[1]] == 'O' and board[line[2]] == 'O'
      return 'Computer'
    end
  end
  return nil
end

def get_endgame_message(winner,game_ending_messages)
  game_ending_messages.select { |k| k == winner }
end

b = initialize_board(true)

draw_board(b)

puts 'Board positions are mapped as shown.'
puts 'Ready to start[press any key]:'
gets.chomp

loop do
  b = initialize_board(false)
  draw_board(b)

  begin 
    player_select_square(b)
    computer_select_square(b)
    draw_board(b)
    winner = check_winner(b)


  end until winner || empty_squares(b).empty?

  if winner
    puts get_endgame_message(winner,game_ending_messages).values.sample
  else
    puts 'Tie Game. Cats and Dogs win.'
  end
  puts 'Would you like to play again?[Y/N]'
  break if gets.chomp.downcase != 'y'
end
puts 'Thanks for playing.'
