class Dealer < User
  PASS_SCORE = 17

  def initialize(name = 'Dealer')
    super(name)
  end

  def game_step(hand)
    if can_pass?(hand.score(@cards))
      pass_move
    elsif can_take_card?
      take_card(hand.deal_one_card)
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
