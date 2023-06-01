module Enumerable
  # Your code goes here
  def my_each_with_index
    index = 0
    array = []
    for element in self
      array.push(yield element, index)
      index += 1
    end
    if !array.include?(nil)
      array
    else
      self
    end
  end

  def my_select
    result = []
    for element in self
      result.push(element) if yield element
    end
    if !result.include?(nil)
      result
    else
      self
    end
  end

  def my_all?
    for element in self
      return false unless yield element
    end
    true
  end

  def my_any?
    for element in self
      return true if yield element
    end
    false
  end

  def my_none?
    for element in self
      return false if yield element
    end
    true
  end

  def my_count
    length = 0
    if block_given?
      for element in self
        length += 1 if yield element
      end
    else
      for _element in self
        length += 1
      end
    end
    length
  end

  def my_map
    array = []
    for element in self
      array.push(yield element)
    end
    if !array.include?(nil)
      array
    else
      self
    end
  end

  def my_inject(initial_value)
    result = initial_value
    for element in self
      result = yield result, element
    end
    result
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    array = []
    for element in self
      array.push(yield element)
    end
    if !array.include?(nil)
      array
    else
      self
    end
  end
end
