require 'pry'
puts "Welcome to Blackjack!"

def get_new_deck()
  suits = %w[H D S C]
  cards = %w[2 3 4 5 6 7 8 9 10 J K Q A]
  deck = suits.product(cards).shuffle
end

player_cards = []
dealer_cards = []

def deal_card(deck, card_hand)
  card_hand << deck.pop
end

def get_total(card_hand)
  total = 0
  aces = 0
  card_hand.each do |card|  
    if /[123456789]/.match(card[1])
      total += card[1].to_i 
      next
    elsif /[JKQ]/.match(card[1])
      total += 10 
      next
    elsif /A/.match(card[1])
      aces += 1 
      next
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
  deal_card(deck,player_cards)
  deal_card(deck,dealer_cards)
  deal_card(deck,player_cards)
  deal_card(deck,dealer_cards)
  show_cards(player_cards,"Player1")

  loop do
    puts "What would you like to do? 1) Hit 2) Stay:"

    hit_or_stay = gets.chomp
    if hit_or_stay != '1' && hit_or_stay != '2'
      puts 'You must enter 1) to Hit or 2) to Stay'
      next
    elsif hit_or_stay == '1'
      show_cards(deal_card(deck,player_cards), "Player1")
      if get_total(player_cards) > 21
        break
      else
        next
      end
    else
      show_cards(player_cards,"Player1")
    end

    until get_total(dealer_cards) >= 17
      puts "Dealer draws. . ."
      show_cards(deal_card(deck,dealer_cards), "Dealer")
    end
    break
  end

  show_winner(dealer_cards,player_cards)

  puts 'Would you like to play again? [Y/N]'

end until gets.chomp.downcase != 'y'

