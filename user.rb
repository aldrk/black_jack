class User
  attr_reader :passed, :taken, :opened, :name, :cards, :balance_amount

  def initialize(name)
    @name = name
    @balance_amount = START_BALANCE
    @cards = []
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
    @cards.concat(cards) if can_take_cards?
  end

  def show_cards_back
    @cards.each { printf('%4s', '#') }
    puts ''
  end

  def show_cards_face
    @cards.each { |card| printf('%4s', "#{card.value}#{card.suit}") }
    puts ''
  end

  def show_balance
    puts "#{@name} balance: #{@balance_amount}"
  end

  def cards_limit_reached?
    @cards.size == MAX_CARDS_COUNT
  end

  def win(bank)
    puts "Congrats, #{@name} win!"
    take_money(bank)
  end

  def clear_cards
    @cards = []
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
    @cards.size < 3
  end

  def can_open_cards?(command)
    command == 'o'
  end
end
