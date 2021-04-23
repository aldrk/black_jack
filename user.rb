# frozen_string_literal: true

# User class
class User
  attr_reader :passed, :taken, :opened, :name, :hand, :balance_amount

  def initialize(name, deck)
    @name = name
    @balance_amount = START_BALANCE
    @hand = Hand.new.deal_cards(deck, 2)
    @passed = false
    @taken = false
    @opened = false
  end

  def make_bet
    @balance_amount -= BET_AMOUNT
    BET_AMOUNT
  end

  def take_money(amount)
    @balance_amount += amount
  end

  def take_cards(cards)
    @hand.concat(cards) if can_take_cards?
  end

  def show_cards_back
    @hand.each { printf(format('%4<sym>s', sym: '?')) }
    puts ''
  end

  def show_cards_face
    @hand.each { |card| printf(format('%4<card>s', card: "#{card.value}#{card.suit}")) }
    puts ''
  end

  def show_balance
    puts "#{@name} balance: #{@balance_amount}"
  end

  def cards_limit_reached?
    @hand.size == MAX_CARDS_COUNT
  end

  def win(bank)
    puts "Congrats, #{@name} win!"
    take_money(bank)
  end

  def clear_cards
    @hand = []
    @passed = false
    @taken = false
    @opened = false
  end

  protected

  BET_AMOUNT = 10
  START_BALANCE = 100
  MAX_CARDS_COUNT = 3

  attr_writer :passed, :taken, :opened

  def pass_move
    puts 'You pass'
    self.passed = true
  end

  def take_card(card)
    puts "#{name} take a card"
    take_cards(card)
    self.taken = true
  end

  def open_cards
    puts "#{name} want to open cards"
    self.opened = true
  end

  def can_take_cards?
    @hand.size < 3
  end

  def can_open_cards?(command)
    command == 'o'
  end
end
