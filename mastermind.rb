class Play

    def initialize
        @game = Game.new
        @welcome_message = false
    end

    def choose_game
        if @welcome_message == false
            @game.welcome
            @welcome_message = true
        end
        puts
        puts "PRESS 1 IF YOU WOULD LIKE TO GUESS"
        puts "PRESS 2 IF YOU WOULD LIKE TO MAKE THE CODE"
        choice = gets.chomp.split('')
        if choice.all? {|x| x.to_i.between?(1,2)} && choice.length == 1
            case choice[0].to_i
            when 1
                start_game
            when 2
                start_player_choice
            end
        else
            puts "PLEASE ENTER 1 OR 2"
            choose_game
        end
        

    end

    def start_game
        @game.computer_game = true
        i = 0
        @game.get_code
        while i < 10 && @game.win == false
          @game.player_input
          @game.check_code
          @game.check_win
          i += 1
        end
    end

    def start_player_choice
        @game.player_game = true
        @game.player_code
        i=0
        while i< 10 && @game.win == false
            @game.computer_guess
            @game.check_code
            @game.check_win
            i += 1
        end
    end
end

class Game
    attr_accessor :win
    attr_accessor :turn_count
    attr_accessor :player_game
    attr_accessor :computer_game
    
    def initialize
        @player_game = false
        @computer_game = false
        @code_size = 4
        @ans_array = []
        @win = false
        @turn_count = 1
    end

    def player_code
        puts
        puts "Enter in your code for the computer to guess"
        puts
        @code = []
        player_input
        @code = @input
    end

    def computer_guess
        puts
        puts "Turn #{@turn_count}"
        puts
        a = Random.new
        @input = []
        @code_size.times {@input.push(a.rand(1..6))}
    end


    def player_input
        puts
        puts "Turn #{@turn_count}"
        puts
        @first_input = gets.chomp.split('')
        @input = []
        if @first_input.all? {|x| x.to_i.between?(1,6)} && @first_input.length == 4
          @first_input.each {|i| @input.push(i.to_i)}
        else
          puts "Please enter 4 numbers between 1 and 6"
          player_input
        end
    end

    def get_code
        a = Random.new
        @code = []
        @code_size.times {@code.push(a.rand(1..6))}
    end

    def check_code
        @ans_array = []
        @input.each_index do |i|
            check_right_number(i)
        end
        print @ans_array
        puts
    end
    
    def check_right_number(position)
            if @code.include?(@input[position])
                check_right_position(@input[position],position)
            else
                @ans_array.push("-")
            end            
    end

    def check_right_position(number,position)
        if @code[position] === number
            @ans_array.push(number)
        else
            @ans_array.push("*")
        end
    end

    def check_win
        if @ans_array == @code && @computer_game == true
            puts
            puts "Congratulations you have guessed the code"
            @win = true
        elsif @ans_array == @code && @player_game == true
            puts
            puts "The computer has figured out your code"
            @win = true
        elsif @turn_count == 10 && @player_game == true
            puts "You have successfully stumped the computer"
        elsif @turn_count == 10 && @computer_game == true
            puts "You have failed."
        else
            puts
            @turn_count += 1
        end
    end

    def welcome
        puts "Welcome To"
        sleep(0.5)
        print "."
        sleep(0.5)
        print "."
        sleep(0.5)
        print "."
        puts ""
        puts "
   _____         _                 _       _ 
  |     |___ ___| |_ ___ ___ _____|_|___ _| |
  | | | | .'|_ -|  _| -_|  _|     | |   | . |
  |_|_|_|__,|___|_| |___|_| |_|_|_|_|_|_|___|
  
  "
  sleep(0.5)
  
  puts "*** HOW TO PLAY THIS GAME ***"
  puts ""
  puts "1 - You will be the codebreaker where you need to predict the secret code"
  sleep (0.5)
  puts ""
  puts "2 - Each round you have to make a correct guess (consist of 4-6 digits) before your rounds are over"
  puts ""
  sleep (0.5)
  puts "3 - After submitting a guess the computer will help you with a feedback symbols indicating each digit status"
  puts ""
  sleep (0.5)
  puts "4 - Below each digit a status that indicates:"
  puts ""
  sleep(1)
  puts "╔═════╦═════════════════════════════════════════════════════════╗"
  puts "║  -  ║ digit does not exist in the code                        ║"            
  puts "╚═════╩═════════════════════════════════════════════════════════╝"
  puts "╔═════╦═════════════════════════════════════════════════════════╗"
  puts "║  *  ║ digit does exist in the code but with diffrent position ║"            
  puts "╚═════╩═════════════════════════════════════════════════════════╝"
  puts "╔═════╦═════════════════════════════════════════════════════════╗"
  puts "║  D  ║ digit exist and in the correct position                 ║"            
  puts "╚═════╩═════════════════════════════════════════════════════════╝"
  puts ""
  puts ""
  sleep(1.5)
  puts "△▽△▽△▽△▽△▽△▽△▽△▽△▽△▽△▽△"
  puts "The GAME Will Start NOW"
  puts "△▽△▽△▽△▽△▽△▽△▽△▽△▽△▽△▽△"
  puts ""
  puts ""
      end

end

@a = Play.new
@a.choose_game