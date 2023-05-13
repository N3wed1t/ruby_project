def bubble_sort(array)
  array.each_with_index do |_value, index|
    array[0..array.length].each_with_index do |_sort_value, sort_index|
      array[index], array[sort_index] = array[sort_index], array[index] if array[index] < array[sort_index]
    end
  end
  array
end

p bubble_sort([26, 43, 37, 20, 24])
