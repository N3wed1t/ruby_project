def fibs(n)
  array = [0]
  if n >= 2 
    array.push(1) 
    return array if n == 2
    (n - 2).times do |index|
      array.push(array[-1] + array[-2])
    end
  end
  array
end 

def fibs_rec(number)
  number < 2 ? number : fibs_rec(number - 1) + fibs_rec(number - 2)
end

def fibs_rec_arr(number)
  array = []
  number.times { |value| array.push(fibs_rec(value))}
  array
end

p fibs_rec_arr(20)