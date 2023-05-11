def bubble_sort(array)
  array.each_with_index do |value, index|
    array[0..array.length].each_with_index do |sort_value, sort_index|
      array[index], array[sort_index] = array[sort_index], array[index] if array[index] < array[sort_index]
    end
  end
  return array
end

p bubble_sort([4,3,78,2,0,2])