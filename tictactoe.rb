require 'pry'
# position from 1 to 9
# initial version comp picks random/open spot
# determine what constitutes a win. Check each time.


# Pick a mark

# draw board with positions labeled

# 1. Ask for position

# 2. draw board with player mark, pause, clear screen and draw board with computer mark

# 3. check for win

# 4. loop back to 1 until winner

# 5. Ask if want to play again (clear board and start again.)
EXAMPLE_MARKERS = true
player_mark = ''
computer_mark = ''
board_positions = []
winner = -1 # -1 no winner, 0 Computer Wins, 1 Player wins


def initialize_board(board_positions, example_flag)
  if example_flag
    (1..9).each {|value| board_positions[value - 1] = value}
  else
    (1..9).each {|value| board_positions[value - 1] = ' '}
  end
end

def draw_board(board_positions)
  system('clear')
  puts '     |     |     '
  puts "  #{board_positions[0]}  |  #{board_positions[1]}  |  #{board_positions[2]}  "
  puts '     |     |     ' 
  puts '-----+-----+-----'
  puts '     |     |     ' 
  puts "  #{board_positions[3]}  |  #{board_positions[4]}  |  #{board_positions[5]} "
  puts '     |     |     ' 
  puts '-----+-----+-----'
  puts '     |     |     '
  puts "  #{board_positions[6]}  |  #{board_positions[6]}  |  #{board_positions[8]}  "
  puts '     |     |     ' 
end

def get_player_position(board_positions)
  loop do
    puts "What's your move?[1-9]:"
    player_position = gets.chomp
    if (1..9).include?(player_position.to_i) and board_positions[player_position.to_i - 1] == ' '
      return player_position
    else
      puts "You must choose a spot between 1 and 9 that is not already occupied."
    end
  end
end

def is_winner?(board_positions, mark)
  if ((board_positions[0] == mark) && (board_positions[1] == mark) && (board_positions[2] == mark)) || 
    ((board_positions[3] == mark) && (board_positions[4] == mark) && (board_positions[5] == mark))  || 
    ((board_positions[6] == mark) && (board_positions[7] == mark) && (board_positions[8] == mark))  ||
    ((board_positions[0] == mark) && (board_positions[3] == mark) && (board_positions[6] == mark))  ||
    ((board_positions[1] == mark) && (board_positions[4] == mark) && (board_positions[7] == mark))  ||
    ((board_positions[2] == mark) && (board_positions[6] == mark) && (board_positions[8] == mark))  ||
    ((board_positions[0] == mark) && (board_positions[4] == mark) && (board_positions[8] == mark))  ||
    ((board_positions[2] == mark) && (board_positions[4] == mark) && (board_positions[6] == mark)) 
    true
  else
    false
  end
end

def computer_pick(board_positions)
  available_positions = []
  board_positions.each_index { |index| 
    if board_positions[index] == ' ' then available_positions << index end
  }
  available_positions.sample
end

def board_full?(board_positions)
  true if !board_positions.include?(' ')
  false
end


loop do

  puts "We're going to play Tic Tac Toe - What mark do you want?[X/O]"
  player_mark = gets.chomp.upcase
  if player_mark == 'X' || player_mark == 'O'
    break
  else
    puts 'Invalide choice!!'
  end
end

player_mark == 'X' ? computer_mark = 'O' : computer_mark = 'X'

loop do
  system('clear')
  puts "The Board will look like this. Select positions as numbered when choosing your moves."

  initialize_board(board_positions,EXAMPLE_MARKERS)

  draw_board(board_positions)

  initialize_board(board_positions,!EXAMPLE_MARKERS)
  loop do 
    board_positions[get_player_position(board_positions).to_i - 1] = player_mark
    draw_board(board_positions)
    board_positions[computer_pick(board_positions)] = computer_mark
    draw_board(board_positions)
    if is_winner?(board_positions,player_mark)
      puts "You won! Our Computer Overlords are not happy."
      break
    elsif is_winner?(board_positions, computer_mark)
      puts "Computer won! Skynet Rulz!"
      break
    elsif board_full?(board_positions)
      puts "Dang. Cat and Dog won :("
      break
    end
  end
  puts "Do you want to play again?[Y/N]"
  break if gets.chomp.downcase != 'y' 
end

