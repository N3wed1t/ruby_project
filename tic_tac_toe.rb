# frozen_string_literal: true

# caution! This project is using colorize for coloring terminal.
require 'colorize'

class Display
  @@number_array = [*1..9]
  def update_table(number = nil, value = nil)
    if number == 'Reset'
      @@number_array = [*1..9]
    elsif !number.nil? || !value.nil?
      @@number_array[number - 1] = value
    end
    @@number_array.each_with_index do |element, index|
      print (index + 1) % 3 != 0 ? "|#{element}" : "|#{element}|\n"
    end
  end
  def number_array
    @@number_array
  end
end

class Player
  attr_accessor :name, :order, :score
  def initialize(name, order)
    @name = name
    @order = order
    @score = 0
  end
  def block_select(display, index, p = order)
    display.update_table(index, order.even? ? 'X' : 'O')
  end
end

class GameLogic
  
  def initialize
    @display = Display.new()
    print '1st Player name => '
    @player1 = Player.new(gets.chomp, 1)
    print "\n2nd Player name => "
    @player2 = Player.new(gets.chomp, 2)
  end

  def run(display = @display, player1 = @player1, player2 = @player2)
    @@used_block = []
    show_score()
    display.update_table('Reset')
    value = 1
    while value < 10 do
      logic = check_logic(display.number_array)
      unless logic == nil
        if logic == 'X win'
          player1.score += 1
          puts "#{player1.name} Win!!"
          break
        elsif logic == "O win"
          player2.score += 1
          puts "#{player2.name} Win!!"
          break
        end
      end
      print "#{value} Select block => "
      input = gets.chomp().to_i
      if @@used_block.include?(input)
        puts 'Duplicate block! Try again'
      elsif input == 0
        puts 'There is no input! Try again'
      else
        @@used_block.push(input)
        show_score(value)
        if value.even?
          player1.block_select(display, input)
        else
          player2.block_select(display, input)
        end
        value += 1
        unless value < 10
          puts 'Draw'
        end
      end
    end
  end

  private
  def check_logic(number_array)
    result = nil
    for value in (0..7) do
      if value < 3
        row_array = number_array[value * 3..(value * 3) + 2]
        result = check_block(row_array) unless check_block(row_array) == nil
      elsif value >= 3 && value < 6 
        col_array = [number_array[value - 3], number_array[value], number_array[value + 3]]
        result = check_block(col_array) unless check_block(col_array) == nil
      else
        if value == 6
          diag_array = number_array[2], number_array[4], number_array[6]
        else
          diag_array = number_array[0], number_array[4], number_array[8]
        end
        result = check_block(diag_array) unless check_block(diag_array) == nil
      end
    end
    result
  end

  def check_block(arr)
    x_array = Array.new(3, 'X')
    o_array = Array.new(3, 'O')
    if  arr == x_array
      'X win'
    elsif arr == o_array
      'O win'
    end
  end

  def show_score(order = 0, player1 = @player1, player2 = @player2)
    if order.even?
      puts "#{player1.name} (X): #{player1.score}".green << ' | ' << "#{player2.name} (O): #{player2.score}".white
    else
      puts "#{player1.name} (X): #{player1.score}".white << ' | ' << "#{player2.name} (O): #{player2.score}".green
    end
  end
end

game = GameLogic.new
loop do
  game.run
  puts 'Type "Yes" to exit, Else is retry'
  break if gets.chomp.downcase == 'yes'
end
