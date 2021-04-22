# frozen_string_literal: true

require_relative 'card'
require_relative 'card_deck'
require_relative 'user'
require_relative 'hand'
require_relative 'dealer'
require_relative 'player'
require_relative 'interface'
require_relative 'black_jack'

interface = Interface.new
BlackJack.new(interface)
