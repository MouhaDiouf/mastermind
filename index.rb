require 'colorize'

class Board 
    def self.colors 
        @@colors = ['r', 'y', 'g', 'p', 'o', 'b']
    end    
end 

class Computer 

    @@computer_guesses = Array.new
    for i in 0..3 
        idx = rand(0...Board.colors.length)
        @@computer_guesses << Board.colors[idx]
    end 

    def self.show_computer_guesses
        @@computer_guesses 
    end 

    def self.check_result(player_guesses)
        right_places = 0
        right_color_wrong_places = 0 
        copy_guesses = @@computer_guesses.dup
        player_guesses.each_with_index do |player_guess, idx|
             if copy_guesses[idx] == player_guess
                right_places += 1
                copy_guesses[idx] = nil 
            elsif copy_guesses.include?(player_guess)
                right_color_wrong_places += 1
                copy_guesses[copy_guesses.find_index(player_guess)] = nil
             end 
        end
        show_results(right_places, right_color_wrong_places) 
        return [right_places, right_color_wrong_places]
    end 

    def self.show_results(right_places, right_color_wrong_places)
        if right_places == 4 
            puts "Congratulations 🎉🎉🎊. You win!!".green
            exit
        end 
        puts " #{right_places} on the right spot!" if right_places > 0
        puts " #{right_color_wrong_places} almost there but on the wrong spot :)" if right_color_wrong_places > 0
        if right_color_wrong_places == 0 && right_places == 0
            puts "Wow no match...try again"
        end 
        
    end 

end 

class Player
    attr_reader :name
    def initialize(name)
        @name = name
        @guesses = []
    end 
end 

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
        puts "Welcome to the Mastermind 🧠 Game!"
        puts "Player one: choose a name"
        player_name = gets.chomp
        while(player_name.length < 1)
            puts "Player one: choose a name"
            player_name = gets.chomp
        end 
        @player_one = Player.new(player_name)
        puts "Great #{player_one.name}!"
        puts "Your computer already chose a combination. You have to guess it! (4 colors)"
        puts "The available colors are: #{Board.colors.join(', ')}."
        player_guess = gets.chomp.split
        while(player_guess.length != 4)
            puts 'Please guess 4 colors (separated by a space)'.red.bold
            player_guess = gets.chomp.split
        end 
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
                puts "Game over :(.".red.bold
            end 
    end 

    private 
    def decrease_guess 
        @guesses -= 1
    end 
end 


game = Game.new 
game.start
