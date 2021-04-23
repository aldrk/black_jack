# frozen_string_literal: true

# rubocop:disable Lint/MissingSuper

# Deck class
class CardDeck < Card
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

# rubocop:enable Lint/MissingSuper
