class Mastermind
    def initialize
    end
    def correct_locations(array1, array2)
        common_elements = 0
        array1.each_with_index do |num, index|
          if array1[index] == array2[index]
            common_elements += 1
          end
        end
        return common_elements
    end
    def keep_correct_locations(array1, array2)
        array1.each_with_index do |num, index|
            if array1[index] == array2[index]
                array1[index] = array2[index]
            else
                array1[index] = rand(1..6)
            end
        end
        return array1
    end
    def correct_numbers(array1, array2)
        common_numbers = 0
        array1.each_with_index do |num, index|
            if array2.include? array1[index]
                common_numbers += 1
            end
        end
        return common_numbers
    end
    def guess
        puts "Type 1 to break the code, type 2 to make the code"
        choice = gets.chomp.to_i
        @number_of_guesses = 1
        if choice == 1
            array = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
            puts "Choose 4 numbers (1-6) to guess the code"
            while @number_of_guesses < 13
                guess = gets.chomp.to_i.digits.reverse
                if guess == array
                    puts "Congratulations! The code was #{array}. You solved the puzzle in #{@number_of_guesses} attempt(s)!"
                    break
                else
                    correct_places = correct_locations(guess, array)
                    correct_digits = correct_numbers(guess, array)
                    puts "Your guess yielded #{correct_places} correct number(s) in correct place(s) and #{correct_digits - correct_places} correct number(s) in incorrect place(s). You have #{12 - @number_of_guesses} attempt(s) remaining"
                    @number_of_guesses += 1
                end
            end
            if @number_of_guesses > 12
                puts "Sorry, you have run out of guesses. The correct code was #{array}"
            end
        elsif choice == 2
            puts "Choose 4 numbers (1-6) to serve as your code"
            array = gets.chomp.to_i.digits.reverse
            guess = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
            while @number_of_guesses < 13
                guess = keep_correct_locations(guess, array)
                if guess == array
                    puts "The computer has guessed #{guess}. Sorry, you lose! The code was #{array}. The computer solved the puzzle in #{@number_of_guesses} attempt(s)!"
                    break
                else
                    correct_places = correct_locations(guess, array)
                    correct_digits = correct_numbers(guess, array)
                    puts "The computer has guessed #{guess}. The computer's guess yielded #{correct_places} correct number(s) in correct place(s) and #{correct_digits - correct_places} correct number(s) in incorrect place(s). The computer has #{12 - @number_of_guesses} attempt(s) remaining"
                    @number_of_guesses += 1
                    if @number_of_guesses > 12
                        puts "Congratulations! The computer has failed to solve your code!"
                    else
                        puts "Type any key to continue"
                        next_move = gets.chomp
                    end
                end
            end
        else 
            puts "ERROR, Type 1 or 2 next time"
        end
    end
end

game = Mastermind.new()
game.guess