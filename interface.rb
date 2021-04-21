class Interface
  def player_name
    puts 'Enter your name'
    name = gets.strip
    raise 'Name cannot be empty' unless name != ''
    name
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def command(user)
    game_commands(user)
    code = gets.strip
    exit_game if code == 'q'
    raise 'Incorrect command' unless %w[p t o].include? code
    code
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def game_commands(user)
    puts 'Enter p if you want to pass' unless user.passed
    puts 'Enter t if you want to get one card' unless user.taken
    puts 'Enter o if you want to open cards'
    puts 'Enter q if you want to quit'
  end

  def confirm_open_cards
    puts 'Press any key to open cards'
    gets
  end

  def confirm_start_new_game
    puts 'Press any key to continue'
    gets
  end

  def greet_player(name)
    puts "Hi, #{name}!"
  end

  def exit_game
    puts 'See you soon'
    exit
  end

  def start_new_game
    puts 'New game:'
  end

  def non_win_game
    puts 'Your points are equal with dealer'
  end

  def start_commands
    puts 'Enter s to start'
    puts 'Enter q to quit'
  end

  def show_score(name, score)
    puts ''
    puts "#{name} result: #{score}"
  end

  def show_bank(bank)
    puts "Bank: #{bank}"
  end

  def error_start_game
    puts 'Please enter s to start, q to exit game'
  end
end
