class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  def initialize
    @head = nil
  end

  def append(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
    else
      current = @head
      current = current.next_node while current.next_node
      current.next_node = new_node
    end
  end

  def prepend(value)
    new_node = Node.new(value, @head)
    @head = new_node
  end

  def size
    count = 0
    current = @head
    while current
      count += 1
      current = current.next_node
    end
    count
  end

  def head
    @head
  end

  def tail
    current = @head
    current = current.next_node while current.next_node
    current
  end

  def at(index)
    return nil if index < 0
    count = 0
    current = @head
    while count < index && current
      current = current.next_node
      count += 1
    end
    current
  end

  def pop
    return if @head.nil?

    if @head.next_node.nil?
      @head = nil
    else
      current = @head
      current = current.next_node while current.next_node.next_node
      current.next_node = nil
    end
  end

  def contains?(value)
    current = @head
    while current
      return true if current.value == value
      current = current.next_node
    end
    false
  end

  def find(value)
    current = @head
    index = 0
    while current
      return index if current.value == value
      current = current.next_node
      index += 1
    end
    nil
  end

  def to_s
    current = @head
    result = ''
    while current
      result += "( #{current.value} ) -> "
      current = current.next_node
    end
    result += 'nil'
    result
  end
end

# Create a new linked list
list = LinkedList.new

# Test #append and #to_s
list.append(1)
list.append(2)
list.append(3)
puts "Linked List: #{list.to_s}" # Should print: ( 1 ) -> ( 2 ) -> ( 3 ) -> nil

# Test #prepend and #to_s
list.prepend(0)
puts "Linked List after prepend: #{list.to_s}" # Should print: ( 0 ) -> ( 1 ) -> ( 2 ) -> ( 3 ) -> nil

# Test #size
puts "Size of the list: #{list.size}" # Should print: Size of the list: 4

# Test #head
puts "Head of the list: #{list.head.value}" # Should print: Head of the list: 0

# Test #tail
puts "Tail of the list: #{list.tail.value}" # Should print: Tail of the list: 3

# Test #at
index = 2
node = list.at(index)
puts "Node at index #{index}: #{node.value}" # Should print: Node at index 2: 2

# Test #pop
list.pop
puts "Linked List after pop: #{list.to_s}" # Should print: ( 0 ) -> ( 1 ) -> ( 2 ) -> nil

# Test #contains?
value_to_check = 2
puts "Does the list contain #{value_to_check}? #{list.contains?(value_to_check)}" # Should print: Does the list contain 2? true

# Test #find
value_to_find = 1
index = list.find(value_to_find)
puts "Index of #{value_to_find}: #{index}" # Should print: Index of 1: 1

# Test #pop again
list.pop
puts "Linked List after pop: #{list.to_s}" # Should print: ( 0 ) -> ( 1 ) -> nil

# Test #pop one more time
list.pop
puts "Linked List after pop: #{list.to_s}" # Should print: ( 0 ) -> nil

# Test #pop when there's only one element
list.pop
puts "Linked List after pop: #{list.to_s}" # Should print: nil

# Test #contains? when the list is empty
value_to_check = 1
puts "Does the list contain #{value_to_check}? #{list.contains?(value_to_check)}" # Should print: Does the list contain 1? false

# Test #find when the list is empty
value_to_find = 0
index = list.find(value_to_find)
puts "Index of #{value_to_find}: #{index}" # Should print: Index of 0: nil
