def caesar_cipher(string, shift = 3)
  string.split('').map do |char| 
    ascii = char.ord
    asciiShifted = char.ord + shift
    if (ascii).between?(65, 90) 
      if (asciiShifted).between?(65, 90) 
        (asciiShifted).chr
      else
        (asciiShifted - 26).chr
      end
    elsif (ascii).between?(97, 122) 
      if (asciiShifted).between?(97, 122) 
        (asciiShifted).chr
      else
        (asciiShifted - 26).chr
      end
    else
      char
    end
  end.join
end

p caesar_cipher("What a string!", 5)