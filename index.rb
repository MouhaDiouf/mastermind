=begin
Classes: Board, Computer, Player     
    
=end


class Board 
    def self.colors 
        @@colors = ['red', 'yellow', 'green', 'purple', 'orange', 'blue']
    end 

   

   
    
end 

class Computer 

    @@selected = Array.new
    for i in 0..3 
        idx = rand(0...Board.colors.length)
        @@selected << Board.colors[idx]
    end 

    def self.show_selected
        @@selected 
    end 

    def self.check_result(player_guesses)
        right_places = 0
        right_color_wrong_places = 0 
        player_guesses.each do |guess|
             
        end 
    end 

end 

class Player
    attr_reader :name
    def initialize(name)
        @name = name
    end 
end 

class Game 
    attr_accessor :player_one
    attr_reader :guesses

    def initialize
        @player_one = nil 
        @guesses = 12
    end 

    def start 
        puts "Welcome to the Mastermind Game!"
        puts "Player one: choose a name"
        player_name = gets.chomp
        @player_one = Player.new(player_name)
        puts "Great #{player_one.name}!"
        puts "Your computer already chose a combination. You have to guess it! (4 colors)"
        puts "The available colors are: #{Board.colors.join(', ')}."
        player_guess = gets.chomp.split
        p player_guess
        while(player_guess.length != 4)
            puts 'Please guess 4 colors (separated by a space)'
            player_guess = gets.chomp.split
        end 
        Computer.check_result(player_guess)
    end 
end 


game = Game.new 
game.start
