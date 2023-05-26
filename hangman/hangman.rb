require 'colorize'



puts 'Game Start!'
def random_word
  word_set = ''
  loop do
    word_set = File.readlines('google-10000-english-no-swears.txt')[Random.rand(9893)].gsub(/\n/, '')
    break if word_set.length.between?(5, 12)
  end
  word_set
end

pole = [' |---|', '     |', '     |', '     |', '_____|']
def display_pole(round, pole)
  hangman_figure = [' O   |', ' |   |', '/|   |', '/|\  |', '/    |', '/ \  |']
  pole_stage = [1, 2, 2, 2, 3, 3]
  pole[pole_stage[round - 1]] = hangman_figure[round - 1] unless round.zero?
  puts pole
  puts "\n"
end

def lose?(round, answer)
  if round >= 6
    puts "You lose! Answer is #{answer}"
    true
  end
end

def win?(hidden_word, answer, input)
  if hidden_word.join == answer || input == answer
    puts 'You win!'
    true
  end
end

def save_game(hidden_word, answer, round, pole)
  puts 'save'
  save = File.open('save1.txt', 'w')
  save.puts [hidden_word.join, answer, round, pole]
end

round = 0
answer = random_word
hidden_word = Array.new(answer.length, '_')

input = ''
if File.exist?('save1.txt')
  puts "Save file detect. \n1. Continue save game\nAnything else will start new game"
  game_select = gets.chomp
  if game_select == '1'
    save_load = File.readlines('save1.txt')
    hidden_word = save_load[0].gsub(/\n/, '').split('')
    answer = save_load[1].gsub(/\n/, '')
    round = save_load[2].gsub(/\n/, '').to_i
    pole = save_load[3..7]
  end
end

loop do
  display_pole(round, pole)
  break if lose?(round, answer)
  break if win?(hidden_word, answer, input)

  hidden_word.each { |value| print value }
  print '     '
  input = gets.chomp
  if input == '1'
    save_game(hidden_word, answer, round, pole)
    break
  elsif input.length == 1 && answer.include?(input)
    answer.split('').each_with_index do |value, index|
      hidden_word[index] = value if input == answer.split('')[index]
    end
  else
    round += 1
  end
  puts ''
end
