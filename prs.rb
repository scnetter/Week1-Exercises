require 'pry'
# RPS Game Play Notes
# Play R/R/S!
# Choose one: (P/R/S)
# mixed case acceptable
# Paper wraps rock
# Scissors cuts paper
# Rock dulls scissors
# Determine logic
# Computer randomly pick value.
# Tie condition
# Keep score?
# end with Play again? (Y/N)
# paper > rock,rock > scissors,scissors > paper or tie
CHOICES = {'p' => {name:'Paper', winning_phrase: "Paper covers Rock!"}, 'r' => {name: 'Rock', winning_phrase: "Rock dulls Scissors!"}, 
  's' => {name: 'Scissors', winning_phrase: "Scissors cuts Paper!"}}

puts "Let's play Rock, Paper, Scissors!"

loop do 
  # 1 = Rock, 2 = Paper, 3 = Scissors
  computer_choice = CHOICES.keys.sample

  puts "Choose one: (P/R/S)"

  user_choice = gets.chomp.downcase

    loop do 
      if !CHOICES.keys.include?(user_choice)
        puts 'Please type P, R, or S to continue:'
        user_choice = gets.chomp.downcase 
      else
        break
      end
    end
  if user_choice == computer_choice
    puts "Well I'll be, you tied!!"
  elsif (user_choice == 'p' && computer_choice == 'r') || (user_choice == 's' && computer_choice == 'p') || 
    (user_choice == 'r' && computer_choice == 's')
    puts "You win! #{CHOICES[user_choice][:winning_phrase]}"
  else
    puts "Computer wins. :( #{CHOICES[computer_choice][:winning_phrase]}"
  end

  puts 'Play again?[Y/N]'
  break if gets.chomp.downcase != 'y'
end
