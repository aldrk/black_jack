class Dealer < User
  PASS_SCORE = 17

  def initialize(deck, name = 'Dealer')
    super(name, deck)
  end

  def game_step(hand, deck)
    if can_pass?(hand.score(@hand))
      pass_move
    elsif can_take_card?
      take_card(hand.deal_one_card(deck))
    else
      open_cards
    end
  end

  protected

  def can_pass?(score)
    score >= PASS_SCORE && !@passed
  end

  def can_take_card?
    !@taken
  end
end
