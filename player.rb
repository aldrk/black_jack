class Player < User
  def game_step(command, hand, deck)
    if can_pass?(command)
      pass_move
    elsif can_take?(command)
      take_card(hand.deal_one_card(deck))
    elsif can_open_cards?(command)
      open_cards
    end
  end

  protected

  def can_pass?(command)
    command == 'p' && !@passed
  end

  def can_take?(command)
    command == 't' && !@taken
  end
end
