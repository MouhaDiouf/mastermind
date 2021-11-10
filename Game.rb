class Game 
    attr_accessor :player_one
    attr_reader :guesses
    attr_reader :history
    def initialize
        @player_one = nil 
        @guesses = 12
        @history = []
    end 

    def print_history 
        history.each do |row|
            row[:guesses].each do |el|
                print "#{el} | "
            end 

            reds_count = row[:results][0]
            whites_count = row[:results][1]           
            reds_count.times { print "•".green}
            whites_count.times {print "•".white}
            print ' | '
            puts
            puts "- + - + - + - + --- "
    end 
    end 

    def start 
        p "Computer guesses" , Computer.show_computer_guesses
        get_user_details
        prompt = TTY::Prompt.new
        choices = 'Do you want to guess or let the computer guess your combination?'
        answers = ['I Guess', 'Computer Guesses']
        answer = prompt.select(choices, answers)
        if answer == answers[0]
            start_user_path
        else 
            start_computer_path
        end 
    end 

    def start_computer_path 
        puts "Choose a color combination and the computer will guess"
        puts "The available colors are: #{Board.colors.join(', ')}."
        player_guess = gets.chomp.split
        while(player_guess.length != 4 || !Player.valid_colors?(player_guess))
            puts "Please guess 4 valid colors (separated by a space). The available colors are: #{Board.colors.join(', ')}. ".yellow.bold
            player_guess = gets.chomp.split
        end 

        @player_one.secret_guess = player_guess
        
        make_computer_guess
    end 



    def make_computer_guess(spot=nil, nearly=nil)

        computer_guess = Computer.make_guess(spot, nearly)
        prompt = TTY::Prompt.new
        question = puts "Computer guessed #{computer_guess.join(' ')}. Is it the right answer?".blue.bold
        answers = ['Yes', 'No...']
        answer = prompt.select(question, answers)
        if answer == answers[0]
            end_game('win', 'computer')
        end 
        Game.end_game if Computer.available_guesses == 0
        puts "Ok...How many are one the spot? (Choose a number)"
        on_spot_computer = gets.chomp.to_i
        puts "How many are somewhere in the colors but not in place?"
        nearly_on_spot_computer = gets.chomp.to_i
        while Computer.available_guesses > 0
            make_computer_guess(on_spot_computer, nearly_on_spot_computer)
        end 
    end 


    def get_user_details
        puts "Welcome to the Mastermind 🧠 Game!"
        puts "Player one: choose a name"
        player_name = gets.chomp
        while(player_name.length < 1)
            puts "Player one: choose a name"
            player_name = gets.chomp
        end 
        @player_one = Player.new(player_name)
        puts "Great #{player_one.name}!"
    end 

    
    def start_user_path
        puts "Choose a color combination and the computer will guess"
        puts "The available colors are: #{Board.colors.join(', ')}."
        player_guess = gets.chomp.split
        while(player_guess.length != 4)
            puts 'Please guess 4 colors (separated by a space)'.red.bold
            player_guess = gets.chomp.split
        end 
        puts "Your computer already chose a combination. You have to guess it! (4 colors)"
        results = Computer.check_result(player_guess)
        @history << { guesses: player_guess, results: results}
        print_history
        decrease_guess
        play_game_logic
    end 


    def play_game_logic
            if (guesses > 0)
                player_guess = gets.chomp.split
                results = Computer.check_result(player_guess)
                decrease_guess
                puts "The available colors are: #{Board.colors.join(', ')}. Choose wisely from previous guesses ;)"
                puts "#{guesses} guesses left..."
                while(player_guess.length != 4)
                    puts 'Please guess 4 colors (separated by a space)'.red.bold
                    player_guess = gets.chomp.split
                end 
                @history << { guesses: player_guess, results: results }
                print_history
                play_game_logic
            else 
                puts "Game over :(. The answer was #{Computer.show_secret.join(' ')}".red.bold
            end 
    end 

    def self.end_game(outcome = nil, player = nil)
        if(outcome == 'win')
            puts "Congratulations 🎉🎉🎊 #{player} won!!".green
        else
            puts "Game over :("
        end 
        exit
    end 

    private 
    def decrease_guess 
        @guesses -= 1
    end 
end 
