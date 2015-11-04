# Case where player gets 21 on initial hand
# Case where player is 21 or Greater, remove option to hit/stay

require 'pry'
puts "Welcome to Blackjack!"

def get_new_deck()
  suits = %w[H D S C]
  cards = %w[2 3 4 5 6 7 8 9 10 J K Q A]
  deck = suits.product(cards).shuffle
end

def deal_card(deck, card_hand)
  card_hand << deck.pop
end

def get_total(card_hand)
  total = 0
  aces = 0
  card_hand.each do |card|  
    if /[1-9]/.match(card[1])
      total += card[1].to_i 
    elsif /[JKQ]/.match(card[1])
      total += 10 
    elsif /A/.match(card[1])
      aces += 1 
    end
  end
  
  if (aces != 0) && (total < 11)
    total += (11 + aces - 1)   
  else
    total += aces
  end
  total
end

def show_cards(card_hand, name)
  print "#{name}'s hand contains "
  card_hand.each { |card| print "#{card} " }
  puts "for a total of #{get_total(card_hand)}."
end

def show_winner(dealer_cards,player_cards)
  player_total = get_total(player_cards)
  dealer_total = get_total(dealer_cards)

  case 
  when player_total > 21
    puts "Dealer Wins - Player Bust"
    return
  when dealer_total > 21
    puts "Player Wins! - Dealer Bust"
    return
  when dealer_total == player_total
    puts "Dealer wins all ties - House Rules!!"
    return  
  when dealer_total == 21
    puts "Dealer Wins! - Blackjack!"
    return
  when player_total == 21
    puts "Player Wins! - Blackjack!"
    return
  when dealer_total > player_total
    puts "Dealer Wins with #{dealer_total}. Player with #{player_total}"
    return
  else
    puts "Player wins with #{player_total}. Dealer with #{dealer_total}"
  end
end


begin 

  deck = get_new_deck
  player_cards = []
  dealer_cards = []
  puts 'Dealing initial cards. . .'

  2.times do
    deal_card(deck,player_cards)
    deal_card(deck,dealer_cards)
  end
  show_cards(player_cards,"Player1")

  loop do
    break if get_total(player_cards) == 21
    puts "What would you like to do? 1) Hit 2) Stay:"

    hit_or_stay = gets.chomp
    if !['1','2'].include?(hit_or_stay)
      puts 'You must enter 1) to Hit or 2) to Stay'
      next
    elsif hit_or_stay == '1'
      show_cards(deal_card(deck,player_cards), "Player1")
      get_total(player_cards) >= 21 ? break : next
    else
      show_cards(player_cards,"Player1")
      break
    end
  end
  
  show_cards(dealer_cards,"Dealer")
  until get_total(dealer_cards) >= 17
    puts "Dealer draws. . ."
    show_cards(deal_card(deck,dealer_cards), "Dealer")
  end

  show_winner(dealer_cards,player_cards)

  puts 'Would you like to play again? [Y/N]'

end until gets.chomp.downcase != 'y'

