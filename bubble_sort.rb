def bubble_sort(array)
  array.each_with_index do |value, index|
    array[0..array.length].each_with_index do |sort_value, sort_index|
      array[index], array[sort_index] = array[sort_index], array[index] if array[index] < array[sort_index]
    end
  end
  return array
end

p bubble_sort([26, 43, 37, 20, 24, 88, 10, 46, 9, 18, 28, 8, 20, 75, 91, 61, 98, 79, 51, 5, 64, 10, 12, 55, 64, 0, 12, 48, 16, 21, 27, 75, 25, 1, 31, 55, 95, 34, 28, 33, 86, 63, 61, 71, 14, 90, 37, 7, 2, 50, 0, 53, 56, 68, 8, 9, 17, 6, 21, 50, 91, 81, 76, 73, 47, 28, 77, 64, 71, 61, 7, 59, 82, 45, 27, 22, 22, 86, 47, 50, 84, 54, 27, 81, 39, 72, 22, 97, 21, 23, 24, 97, 11, 34, 28, 92, 30, 79, 67, 3])