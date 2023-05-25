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
round = 0
answer = random_word
hidden_word = Array.new(answer.length, '_')
loop do
  display_pole(round, pole)
  if round >= 6
    puts "You lose! Answer is #{answer}"
    break
  end
  if hidden_word.join == answer
    puts 'You win!'
    break
  end
  hidden_word.each { |value| print value }
  print '     '
  input = gets.chomp
  if input == answer
    puts 'You win!'
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
