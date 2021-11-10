class Player
    attr_reader :name
    attr_accessor :secret_guess
    def initialize(name)
        @name = name
        @guesses = []
        @secret_guess = nil 
    end 

    def self.valid_colors?(guess)
        guess.all? {|color| Board.colors.include?(color)}
    end 
end 
