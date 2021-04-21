class CardDeck
  CARD_SUITS = %w[♡ ♧ ♢ ♤].freeze
  CARD_VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize
    @cards = create_deck
  end

  def cards(count)
    @cards.sample(count).each { |value| @cards.delete(value) }
  end

  private

  def create_deck
    cards = []
    CARD_SUITS.each do |suit|
      CARD_VALUES.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards.shuffle
  end
end
