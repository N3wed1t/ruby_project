require 'colorize'


class Display
  def show_result(input = '0000')
    color_set = ['0'.white, '0'.green, '0'.blue, '0'.yellow, '0'.magenta, '0'.red]
    input_array = input.split('')
    result = '|'
    input_array.each { |element| result += color_set[element.to_i - 1] }
    result += '|'
  end

  def random_floor
    Random.new.rand(1..6)
  end

  def random_answer
    [random_floor, random_floor, random_floor, random_floor]
  end
end

class Player
  def initialize
    @game = GameLogic.new
  end

  def select_role
    puts 'Select role by enter 1 if play as Code Breaker, 2 as Code Maker'
    role = gets.chomp.to_i
    if role == 1
      @game.run_code_breaker
    elsif role == 2
      @game.run_code_maker
    end
  end
end

class GameLogic
  def initialize
    @display = Display.new
    @answer_key = @display.random_answer.join
    # @answer_key = '4617'
  end

  def input_verifier(hash, user_input)
    if input_checker(user_input)
      hash[:input].push(user_input)
      hash[:round] += 1 if hash.key?(:round)
    else
      puts 'Input should be exactly 4 length long'.red
    end
  end

  def output_assembler(breaker, index)
    output = "#{index + 1}#{' ' if index < 9} "
    output += "#{@display.show_result(breaker[:input][index])} "
    output.concat(check_answer(breaker[:input][index]).to_s)
  end

  def code_processor(breaker)
    input_verifier(breaker, gets.chomp)
    breaker[:input].each_with_index do |_value, index|
      print output_assembler(breaker, index)
    end
    input_text_color_number
  end

  def win?(breaker)
    check_answer(breaker[:input][-1]).split.include?('You') && input_checker(breaker[:input][-1])
  end

  def run_code_breaker
    puts "Input in these format: => 1234 >> |#{'0'.green}#{'0'.blue}#{'0'.yellow}#{'0'.magenta}|"
    input_text_color_number
    breaker = { input: [], round: 1 }
    while breaker[:round] <= 12
      code_processor(breaker)
      break if win?(breaker)
    end
    puts "You lose here is the answer: #{@answer_key} #{@display.show_result(@answer_key)}"
  end

  def input_text_color_number
    puts "With this color number: 1 #{'2'.green} #{'3'.blue} #{'4'.yellow} #{'5'.magenta} #{'6'.red}\n"
    print '=> '
  end

  def run_code_maker
    maker = { input: [] }
    puts "Enter your code in these format: => 1234 >> |#{'0'.green}#{'0'.blue}#{'0'.yellow}#{'0'.magenta}|"
    input_text_color_number
    input_verifier(maker, gets.chomp)
    puts "#{@display.show_result(maker[:input][0])} This is your code. Lets watch computer solve it!"
  end

  def input_checker(user_input)
    user_input.length == 4 && user_input.split('').map(&:to_i).max.between?(1, 6)
  end

  def position_checker(answer_array, answer_key_array, result = '')
    answer_array.each_with_index do |value, index|
      if value == answer_key_array[index]
        result += "\e[0;31;49mo\e[0m "
        answer_key_array[index] = 'x'
      elsif answer_key_array.include?(value)
        result += 'o '
        answer_key_array[answer_key_array.find_index(value)] = 'x'
      end
    end
    result.split(' ').sort.join.concat("\n")
  end

  def check_answer(answer)
    answer_key_array = @answer_key.split('')
    answer_array = answer.split('')
    if answer == @answer_key
      "oooo You win!!\n".red
    elsif answer_array.intersect?(answer_key_array)
      position_checker(answer_array, answer_key_array)
    else
      "\n"
    end
  end
end

Player.new.select_role
