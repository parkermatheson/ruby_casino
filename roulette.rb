# PLAY ROULETTE

# setup wheel
@wheel = [0, 28, 9, 26, 30, 11, 7, 20, 32, 17, 5, 22, 34, 15, 3, 24, 36, 13, 1, '00', 27, 10, 25, 29, 12, 8, 19, 31, 18, 6, 21, 33, 16, 4, 23, 35, 14, 2]

# setup payout rules for bets in a hash

# even = 1 to 1
# odd = 1 to 1
# red = 1 to 1
# black = 1 to 1
# 0 = 35 to 1
# 00 = 35 to 1
# 1 to 18 = 1 to 1
# 19 to 36 = 1 to 1
# straight up = 35 to 1
# etc...

@payout = {
  "even" => 1,
  "odd" => 1,
  "red" => 1,
  "black" => 1,
  "0" => 35,
  "00" => 35,
  "1" => 35,
  "2" => 35,
  "3" => 35,
  "4" => 35,
  "5" => 35,
  "6" => 35,
  "7" => 35,
  "8" => 35,
  "9" => 35,
  "10" => 35,
  "11" => 35,
  "12" => 35,
  "13" => 35,
  "14" => 35,
  "15" => 35,
  "16" => 35,
  "17" => 35,
  "18" => 35,
  "19" => 35,
  "20" => 35,
  "21" => 35,
  "22" => 35,
  "23" => 35,
  "24" => 35,
  "25" => 35,
  "26" => 35,
  "27" => 35,
  "28" => 35,
  "29" => 35,
  "30" => 35,
  "31" => 35,
  "32" => 35,
  "33" => 35,
  "34" => 35,
  "35" => 35,
  "36" => 35,
  "row" => 17,
  "split" => 17,
  "street" => 11,
  "corner" => 8,
  "first_column" => 2,
  "second_column" => 2,
  "third_column" => 2,
  "first_dozen" => 2,
  "second_dozen" => 2,
  "third_dozen" => 2,
  "1 to 18" => 1,
  "19 to 36" => 1
}
# if spin is an integer within the same category the user bet on, calculate the payout.
# categories
#   first_dozen
#     (1..12)
#   second_dozen
#     (13..24)
#   third_dozen
#     (25..36)
#   first_column
#     (1, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34)
#   second_column
#     (2, 5, 8, 11, 14, 17, 20, 23, 26, 29, 32, 35)
#   third_column
#     (3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36)
#   odd
#     .odd?
#   even
#     .even?
#   red
#     (1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36)
#   black
#     (2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35)

# how much money will player's wallet start with?
@wallet = 500

@table = {
  zero: { payout: 35, nums: [0] },
  doublezero: { payout: 35, nums: ['00'] },
  straight: { payout: 35, nums: (1..36).to_a },
  first_column: { payout: 2, nums: (1..34).step(3).to_a },
  second_column: { payout: 2, nums: (2..35).step(3).to_a },
  third_column: { payout: 2, nums: (3..36).step(3).to_a },
  first_dozen: { payout: 2, nums: (1..12).to_a },
  second_dozen: { payout: 2, nums: (13..24).to_a },
  third_dozen: { payout: 2, nums: (25..36).to_a },
  odd: { payout: 1, nums: (1..35).step(2).to_a },
  even: { payout: 1, nums: (2..36).step(2).to_a },
  red: { payout: 1, nums: [1, 3, 5, 7, 9, 12, 14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36] },
  black: { payout: 1, nums: [2, 4, 6, 8, 10, 11, 13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35] },
  one_to_eighteen: { payout: 1, nums: (1..18).to_a },
  nineteen_to_thirtysix: { payout: 1, nums: (1..18).to_a }
}

# p @table

def intro_message
  puts 'Welcome to roulette!'
end

def bet
  puts 'where will you place your bet?'
  # player_bet_category = gets.chomp!
  @player_bet_category = gets.chomp!
  p @player_bet_category
  puts 'how much will you bet?'
  @bet_value = gets.chomp!.to_i
  @wallet -= @bet_value
  puts "you now have $#{@wallet} left in your wallet."
end

def spin
  puts 'spinning...'
  @ball = @wheel.sample
  p @ball
end
  # MATHS
  # if spin is an integer within the same category the user bet on, calculate the payout.
  # compare spin to all the integers within categories.player_bet_category

# if categories.player_bet_category.value?(spin)
def maths(bet_name, bet_value)
  # if @table[:@player_bet_category]
  p @table.dig(@player_bet_category.to_sym, :nums)
  p @ball
  if @table.dig(@player_bet_category.to_sym, :nums).include?(@ball)
    # if @ball == @player_bet_category
    winnings = @bet_value * @payout[@player_bet_category.to_s]
    puts "YOU WIN $#{winnings}!!!"
    @wallet += winnings
    puts "your wallet now has $#{@wallet}"
  else
    puts "you have $#{@wallet} left."
  end
end

def turn
  while @wallet > 0
    bet
    spin
    maths(@player_bet_category, @bet_value)
    break if @wallet <= 0
  end
end

def goodbye
  puts 'better luck next time'
end
# if player wants to quit
#   say goodbye
# else
#   do another turn

intro_message
turn
goodbye
