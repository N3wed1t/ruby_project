example_array = [34, 90, 2, 4, 96, 72, 9, 35, 98, 19, 14, 97, 14, 90, 75, 20]

def split_half(array)
  if array.length > 2
    left_array = split_half(array[0..(array.length / 2).floor - 1])
    right_array = split_half(array[(array.length / 2).ceil..])
    merge_sort(left_array, right_array)
  elsif array.length == 2
    sort_two(array)
  else
    array
  end
end

def sort_two(array)
  array[0], array[1] = array[1], array[0] if array[0] > array[1]
  array
end

def merge_sort(left_array, right_array)
  left_counter = 0, right_counter = 0
  new_array = []
  while left_counter < left_array.length || right_counter < right_array.length
    if left_counter >= left_array.length && right_counter < right_array.length
      new_array.append(right_array[right_counter])
      right_counter += 1
    elsif right_counter >= right_array.length && left_counter < left_array.length
      new_array.append(left_array[left_counter])
      left_counter += 1
    elsif left_array[left_counter] < right_array[right_counter]
      new_array.append(left_array[left_counter])
      left_counter += 1
    elsif left_array[left_counter] > right_array[right_counter]
      new_array.append(right_array[right_counter])
      right_counter += 1
    elsif left_array[left_counter] == right_array[right_counter]
      new_array.append(left_array[left_counter])
      left_counter += 1
    end
  end
  new_array
end

t1 = Time.now
p split_half(example_array)
t2 = Time.now
delta = t2 - t1 # in seconds
puts "Time=#{delta}"
