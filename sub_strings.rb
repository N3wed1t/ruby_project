dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(strings, dictionary)
  dictionary.reduce(Hash.new(0)) do |word, check|
    strings.downcase.split(" ").each do |string|
      if string.downcase.include?(check)
        word[check] += 1
      end
    end
    word
  end
end

puts substrings("Howdy partner, sit down! How's it going?", dictionary)