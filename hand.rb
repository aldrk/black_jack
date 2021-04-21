class Hand
  ACE_MIN = 1
  ACE_MAX = 11
  WIN_POINTS = 21
  DEFAULT_VALUE = 10

  def initialize
    @cards = []
  end

  def deal_cards(count = 2, card_deck)
    @cards = card_deck.cards(count)
  end

  def deal_one_card(card_deck)
    deal_cards(1, card_deck)
  end

  def score(cards)
    total_score = 0
    ace_count = 0
    cards.each do |card|
      ace_count += ACE_MIN if card.value == 'A'
      total_score += get_card_score(card)
    end
    add_ace_to_score(total_score, ace_count)
  end

  def non_win?(player_score, dealer_score)
    player_score == dealer_score
  end

  def player_win?(player_score, dealer_score)
    win_score?(player_score) || player_less_difference?(player_score, dealer_score)
  end

  def player_less_difference?(player_score, dealer_score)
    score_difference(player_score) < score_difference(dealer_score)
  end

  protected

  def get_card_score(card)
    if %w[J Q K].include? card.value
      DEFAULT_VALUE
    elsif card.value == 'A'
      ACE_MIN
    else
      card.value.to_i
    end
  end

  def add_ace_to_score(total_score, ace_count)
    ace_count.times do
      ace_score = ACE_MAX - ACE_MIN
      total_score += ace_score if total_score + ace_score <= WIN_POINTS + 5
    end
    total_score
  end

  def win_score?(score)
    WIN_POINTS == score
  end

  def score_difference(score)
    (WIN_POINTS - score).abs
  end
end
