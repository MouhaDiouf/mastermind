
class Computer 
    @@last_guess = nil 
    @@available_guesses = 1
    @@intelligent_guess = nil 
    @@computer_secret = nil 

    def self.generate_random_colors
        colors = Array.new
        for i in 0..3 
            idx = rand(0...Board.colors.length)
            colors << Board.colors[idx]
        end 
        return colors
    end 

    def self.available_guesses
        @@available_guesses
    end 

    def self.show_secret 
        @@computer_secret
    end 


    def self.show_computer_guesses
        @@computer_secret = generate_random_colors
    end 

    def self.check_result(player_guesses)
        right_places = 0
        right_color_wrong_places = 0 
        copy_comp_secret = @@computer_secret.dup
        copy_player_guesses = player_guesses.dup 
        copy_player_guesses.each_with_index do |player_guess, idx|
             if copy_comp_secret[idx] == player_guess
                right_places += 1
                copy_comp_secret[idx] = nil 
                copy_player_guesses[idx] = 'X'
             end 
        end
       
        copy_player_guesses.each_with_index do |player_guess|
            if copy_comp_secret.include?(player_guess)
                right_color_wrong_places += 1
                copy_comp_secret[copy_comp_secret.find_index(player_guess)] = nil
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

    def self.make_guess(spot, nearly)
        @@available_guesses -= 1
        if(spot.nil? && nearly.nil?)
        @@last_guess =  generate_random_colors
        else
           @last_guess = make_better_guess(spot, nearly)
        end 
    end 

    def self.make_better_guess(spot, nearly_spot)
      guess =  @@last_guess.slice(rand(0..3), spot) 
      nearly_spot.times { guess << @@last_guess[rand(0..3)] }
      while guess.length < 4
        guess << Board.colors[rand(0..3)]
      end
      guess
    end 


end 