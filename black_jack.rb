class BlackJack
  def initialize(interface)
    @interface = interface
    initialize_game
    while (code = gets.strip)
      game_continue(code)
    end
  end

  protected

  attr_accessor :bank, :game_over

  def initialize_game
    @player = Player.new(@interface.player_name)
    @interface.greet_player(@player.name)
    @dealer = Dealer.new
    @interface.start_commands
  end

  def game_continue(code)
    case code
    when 's'
      start_game
    when 'q'
      @interface.exit_game
    else
      @interface.error_start_game
    end
  end

  def start_game
    @interface.start_new_game
    @bank = 0
    @game_over = false
    @hand = Hand.new
    make_bets
    play_game
    open_cards
  end

  def make_bets
    self.bank += @player.make_bet
    self.bank += @dealer.make_bet
  end

  def play_game
    until @game_over
      player_step
      break if @game_over || players_cards_limit_reached?
      dealer_step
      stop_game if players_cards_limit_reached?
    end
  end

  def player_step
    game_info
    @player.game_step(@interface.command(@player), @hand)
    self.game_over = @player.opened
  end

  def dealer_step
    game_info
    @dealer.game_step(@hand)
    self.game_over = @dealer.opened
  end

  def open_cards
    self.game_over = true
    @interface.confirm_open_cards
    game_info
    winner
    clear_bank
    collect_cards
    show_balances_amount
    @interface.exit_game if players_cannot_play?
    @interface.start_commands
  end

  def collect_cards
    @player.clear_cards
    @dealer.clear_cards
  end

  def show_balances_amount
    @player.show_balance
    @dealer.show_balance
    puts
  end

  def game_info
    @dealer.show_cards_back unless @game_over
    @dealer.show_cards_face if @game_over
    @player.show_cards_face

    @interface.show_score(@dealer.name, @hand.score(@dealer.cards)) if @game_over
    @interface.show_score(@player.name, @hand.score(@player.cards))

    @interface.show_bank(@bank)
  end

  def stop_game
    game_info
    self.game_over = true
  end

  def winner
    player_result = @hand.score(@player.cards)
    dealer_result = @hand.score(@dealer.cards)
    if @hand.non_win?(player_result, dealer_result)
      @interface.non_win_game
      players_take_money(@bank / 2.0)
    elsif @hand.player_win?(player_result, dealer_result)
      @player.win(@bank)
    else
      @dealer.win(@bank)
    end
  end

  def players_take_money(amount)
    @dealer.take_money(amount)
    @player.take_money(amount)
  end

  def clear_bank
    self.bank = 0
  end

  def players_cards_limit_reached?
    @player.cards_limit_reached? && @dealer.cards_limit_reached?
  end

  def players_cannot_play?
    @player.balance_amount.zero? || @dealer.balance_amount.zero?
  end
end
